//
//  WeatherRepository.swift
//  DVT Weather
//
//  Created by Bedan Kimani on 10/01/2025.
//
import Combine

protocol WeatherRepository{
    
    func fetchForecast(locationId:String, lat: Double, lon: Double) -> AnyPublisher<DayForecast?, Error>
    
    func fetchCachedForecast(locationId:String) -> AnyPublisher<DayForecast?, Error>
        
}
