//
//  AddLocationViewModel.swift
//  DVT Weather
//
//  Created by Bedan Kimani on 13/01/2025.
//
import SwiftUI
import GooglePlaces
import Combine

class AddLocationViewModel:ObservableObject {
    
    private let token = GMSAutocompleteSessionToken.init()
    private let client = GMSPlacesClient.shared()
    @Published var error:String? = nil
    @Published var loading:Bool = false
    @Published var locations:[Location] = []
    @Published var selectedLocaiton:Location? = nil
    @Published var searchTerm = ""
    private var cancellables:Set<AnyCancellable> = []
    
    private var filter:GMSAutocompleteFilter{
        let filter = GMSAutocompleteFilter()
        filter.countries = ["KE", "ZA", "AE"]
        filter.types = ["locality"]
        return filter
    }
    
    let locationRepository:LocationRepository
    let weatherRepository:WeatherRepository
    
    init(
        locationRepository:LocationRepository = DefaultLocationRepository(),
        weatherRepository:WeatherRepository = DefaultWeatherRepository()
    ) {
        self.weatherRepository = weatherRepository
        self.locationRepository = locationRepository
        $searchTerm
            .filter({ $0.count >= 3 })
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink { search in
                self.search(query: search)
            }
            .store(in: &cancellables)
    }
    
    
    private func search(query:String){
        withAnimation{
            self.loading = true
            self.error = nil
        }
        client.findAutocompletePredictions(fromQuery: query,filter: filter, sessionToken: token, callback: {[weak self] (results, error) in
            self?.loading = false
            if let error = error {
                self?.error = error.localizedDescription
                return
            }
            self?.locations = results?.map{
                Location(
                  id: $0.placeID,
                  name: $0.attributedPrimaryText.string,
                  fullAddress: $0.attributedFullText.string
                )
            } ?? []
        })
    }
    
    
    func fetchSelectedLocationWeather(location:Location){
        var location = location
        guard let name = location.name else { return }
        withAnimation{
            self.loading = true
        }
        locationRepository.geoCodeLocation(name)
            .compactMap(\.?.results.first)
            .map(\.geometry.location)
            .map{result -> Location in
                location.lat = result.lat
                location.lon = result.lng
                return location
            }
            .flatMap{[self] location -> AnyPublisher<DayForecast?,Error> in
                return weatherRepository.fetchForecast(locationId: location.id!, lat: location.lat!, lon: location.lon!)
            }
            .receive(on: DispatchQueue.main)
            .sink {[weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
                self?.loading = false
            } receiveValue: {[weak self] forecast in
                if let forecast{
                    location.forecast = [forecast]
                    self?.selectedLocaiton = location
                }
            }
            .store(in: &cancellables)

    }
    
    func saveLocation(callback:@escaping(Location)->Void){
        guard let selectedLocaiton else { return }
        locationRepository.saveLocation(selectedLocaiton)
            .receive(on: DispatchQueue.main)
            .sink {[weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
            } receiveValue: { location in
                callback(selectedLocaiton)
            }
            .store(in: &cancellables)
    }

    
}
