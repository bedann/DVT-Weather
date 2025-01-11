//
//  LocationsViewModel.swift
//  DVT Weather
//
//  Created by Bedan Kimani on 11/01/2025.
//

import Combine
import SwiftUI
import Foundation
import GooglePlaces
import CoreLocation

class LocationsViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()
    @Published var error:String? = nil
    @Published var locations:[Location] = []
    @Published var myLocation:Location? = nil
    
    private var cancellables:Set<AnyCancellable> = []
    let repository:LocationRepository
    let weatherRepository:WeatherRepository
    
    init(
        repository:LocationRepository = DefaultLocationRepository(),
        weatherRepository:WeatherRepository = DefaultWeatherRepository()
    ) {
        self.repository = repository
        self.weatherRepository = weatherRepository
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestWhenInUseAuthorization()
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse{
            getCurrentLocation()
        }
    }
    
    func saveLocation(_ location:Location) {
        repository.saveLocation(location)
            .receive(on: DispatchQueue.main)
            .sink {[weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
            } receiveValue: { _ in
                
            }
            .store(in: &cancellables)
    }
    
    func getLocations() {
        repository.fetchLocations()
            .receive(on: DispatchQueue.main)
            .sink {[weak self] completion in
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
            } receiveValue: {[weak self] locations in
                self?.locations = locations
            }
            .store(in: &cancellables)
    }
    
    var isCurrentLocationSaved:Bool {
        locations.contains(where: { $0.id == myLocation?.id })
    }
    
    func getCurrentLocation() {
        let placesClient = GMSPlacesClient.shared()
        
        let fields = GMSPlaceField(rawValue:
            UInt64(GMSPlaceField.name.rawValue) |
            UInt64(GMSPlaceField.placeID.rawValue) |
            UInt64(GMSPlaceField.formattedAddress.rawValue) |
            UInt64(GMSPlaceField.coordinate.rawValue)
        )
        
        placesClient.findPlaceLikelihoodsFromCurrentLocation(withPlaceFields: fields, callback: {[weak self]
          (placeLikelihoodList: Array<GMSPlaceLikelihood>?, error: Error?) in
          if let error = error {
              print("Places likelihood error occurred: \(error.localizedDescription)")
              self?.error = error.localizedDescription
              return
          }

          if let placeLikelihoodList = placeLikelihoodList {
              if
                let mostLikelyPlace = placeLikelihoodList.sorted(by: { $0.likelihood > $1.likelihood }).first?.place,
                let placeId = mostLikelyPlace.placeID,
                let placeName = mostLikelyPlace.name
              {
                  self?.myLocation = Location(
                    id: placeId,
                    name: placeName,
                    fullAddress: mostLikelyPlace.formattedAddress,
                    lat: mostLikelyPlace.coordinate.latitude,
                    lon: mostLikelyPlace.coordinate.longitude
                  )
              }
          }
        })
    }
    
    func getCurrentLocationCachedWeather() {
        guard let locationId = myLocation?.id else {
            return
        }
        weatherRepository.fetchCachedForecast(locationId: locationId)
            .receive(on: DispatchQueue.main)
            .compactMap{ $0 }
            .sink { completion in
                
            } receiveValue: {[weak self] forecast in
                self?.myLocation?.forecast = [forecast]
            }
            .store(in: &cancellables)
    }
    
}
