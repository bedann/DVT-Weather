//
//  DefaultWeatherRepository.swift
//  DVT Weather
//
//  Created by Bedan Kimani on 10/01/2025.
//
import Combine
import Foundation

class DefaultWeatherRepository:WeatherRepository{
    
    private let client = DefaultClient<WeatherApi>()
    private let dbService:DBService
    
    init(dbService: DBService = SQLDbService(database: .shared)) {
        self.dbService = dbService
        
    }
    
    func fetchForecast(locationId:Int? = nil, lat: Double, lon: Double) -> AnyPublisher<DayForecast?,Error> {
        Publishers.Merge(
            dbService.loadForecast(for: locationId),
            forecastRemotePublisher(lat: lat, lon: lon)
        )
        .eraseToAnyPublisher()
    }
    
    private func forecastRemotePublisher(lat: Double, lon: Double) -> AnyPublisher<DayForecast?, Error> {
        Publishers.Zip(
            currentForecastPublisher(lat: lat, lon: lon),
            weekForecastPublisher(lat: lat, lon: lon)
        )
        .subscribe(on: DispatchQueue.global(qos: .userInitiated))
        .map{ (current, weekly) in
            DayForecast(currentForecast: current, weekForecast: weekly, location: weekly.city.name, locationId: weekly.city.id)
        }
        .flatMap{[dbService] forecast in
            return dbService.saveForecast(forecast)
        }
//        .catch({ error -> AnyPublisher<DayForecast?,Error> in
//            if error.isOfflineError{
//                return Just(nil).setFailureType(to: Error.self).eraseToAnyPublisher()
//            }
//            return Fail(error: error).eraseToAnyPublisher()
//        })
        .eraseToAnyPublisher()
    }
    
    private func currentForecastPublisher(lat: Double, lon: Double) -> AnyPublisher<CurrentForecast, Error> {
        client.fetch(from: .getCurrent(lat: lat, lon: lon))
    }
    
    private func weekForecastPublisher(lat: Double, lon: Double) -> AnyPublisher<WeekForecast, Error> {
        client.fetch(from: .getForecast(lat: lat, lon: lon))
    }
    
}
