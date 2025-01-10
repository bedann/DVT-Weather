//
//  DBService.swift
//  DVT Weather
//
//  Created by Bedan Kimani on 10/01/2025.
//


import Foundation
import Combine

protocol DBService{
    
    func loadForecast(for cityId: Int?) -> AnyPublisher<DayForecast?,Error>
    
    func saveForecast(_ forecast: DayForecast) -> AnyPublisher<DayForecast?,Error>
    
}
