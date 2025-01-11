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
    
    func fetchCachedForecast(locationId: String) -> AnyPublisher<DayForecast?, any Error> {
        dbService.loadForecast(for: locationId).eraseToAnyPublisher()
    }
    
    func fetchForecast(locationId:String, lat: Double, lon: Double) -> AnyPublisher<DayForecast?,Error> {
        Publishers.Merge(
            dbService.loadForecast(for: locationId),
            forecastRemotePublisher(locationId: locationId, lat: lat, lon: lon)
        )
        .eraseToAnyPublisher()
    }
    
    private func forecastRemotePublisher(locationId:String, lat: Double, lon: Double) -> AnyPublisher<DayForecast?, Error> {
        Publishers.Zip(
            currentForecastPublisher(lat: lat, lon: lon),
            weekForecastPublisher(lat: lat, lon: lon)
        )
        .subscribe(on: DispatchQueue.global(qos: .userInitiated))
        .map{ (current, weekly) in
            DayForecast(currentForecast: current, weekForecast: weekly, location: weekly.city.name, locationId: locationId)
        }
        .flatMap{[dbService] forecast in
            return dbService.saveForecast(forecast)
        }
        .eraseToAnyPublisher()
    }
    
    private func currentForecastPublisher(lat: Double, lon: Double) -> AnyPublisher<CurrentForecast, Error> {
        client.fetch(from: .getCurrent(lat: lat, lon: lon))
    }
    
    private func weekForecastPublisher(lat: Double, lon: Double) -> AnyPublisher<WeekForecast, Error> {
        client.fetch(from: .getForecast(lat: lat, lon: lon))
    }
    
}
