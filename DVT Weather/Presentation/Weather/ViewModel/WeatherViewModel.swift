//
//  WeatherViewModel.swift
//  DVT Weather
//
//  Created by Bedan Kimani on 11/01/2025.
//
import Foundation
import Combine
import SwiftUI

class WeatherViewModel:ObservableObject{
    
    @Published var forecast:DayForecast? = nil
    @Published var error:String? = nil
    @Published var loading:Bool = false
    private var cancellables:Set<AnyCancellable> = []
    
    private let repository:WeatherRepository
    
    init(repository:WeatherRepository = DefaultWeatherRepository()){
        self.repository = repository
    }
    
    func fetchForecast(location:Location){
        guard
            let latitude = location.lat,
            let longitude = location.lon,
            let locationId = location.id
        else{
            self.error = "Invalid location"
            return
        }
        withAnimation{
            self.loading = true
        }
        repository.fetchForecast(locationId: locationId, lat: latitude, lon: longitude)
            .receive(on: DispatchQueue.main)
            .sink {[weak self] completion in
                withAnimation{
                    self?.loading = false
                }
                if case .failure(let error) = completion {
                    self?.error = error.localizedDescription
                }
            } receiveValue: {[weak self] forecast in
                self?.forecast = forecast
            }
            .store(in: &cancellables)
    }
    
}
