//
//  MockWeatherRepository.swift
//  DVT Weather
//
//  Created by Bedan Kimani on 14/01/2025.
//
@testable import DVT_Weather
import Combine

class MockWeatherRepository:WeatherRepository{
    
    func fetchForecast(locationId: String, lat: Double, lon: Double) -> AnyPublisher<DVT_Weather.DayForecast?, any Error> {
        var sample = DayForecast.sample
        sample.locationId = locationId
        return Just(sample).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
    func fetchCachedForecast(locationId: String) -> AnyPublisher<DVT_Weather.DayForecast?, any Error> {
        Just(DayForecast.sample).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
    
    
    
}
