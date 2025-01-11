//
//  DBService.swift
//  DVT Weather
//
//  Created by Bedan Kimani on 10/01/2025.
//


import Foundation
import Combine

protocol DBService{
    
    func loadForecast(for locationId: String?) -> AnyPublisher<DayForecast?,Error>
        
    func saveForecast(_ forecast: DayForecast) -> AnyPublisher<DayForecast?,Error>
    
    func fetchLocations() -> AnyPublisher<[LocationForecast],Error>
    
    func saveLocation(_ location: LocationEntity) -> AnyPublisher<LocationEntity?,Error>
    
}
