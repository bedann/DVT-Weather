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
        fetchForecast()
    }
    
    func fetchForecast(){
        withAnimation{
            self.loading = true
        }
        repository.fetchForecast(locationId: nil, lat: -1.2156928, lon: 36.8672768)
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
