//
//  DefaultLocationRepository.swift
//  DVT Weather
//
//  Created by Bedan Kimani on 12/01/2025.
//

import Combine
import Foundation

class DefaultLocationRepository:LocationRepository{
    
    
    private let client = DefaultClient<LocationsApi>()
    private let dbService:DBService
    
    init(dbService: DBService = SQLDbService(database: .shared)) {
        self.dbService = dbService
        
    }
    
    func fetchLocations() -> AnyPublisher<[Location], any Error> {
        dbService.fetchLocations().map{ locationForecasts in
            return locationForecasts.map{ locationForecast in
                var location = locationForecast.location.toDomainLocation()
                location.forecast = locationForecast.forecast ?? []
                return location
            }
        }
        .eraseToAnyPublisher()
    }
    
    func saveLocation(_ location: Location) -> AnyPublisher<Location, any Error> {
        dbService.saveLocation(LocationEntity.from(location))
            .compactMap{ $0?.toDomainLocation() }
            .eraseToAnyPublisher()
    }
    
    
    func geoCodeLocation(_ name: String) -> AnyPublisher<GeoCodeLocationResultResponse?, any Error> {
        client.fetch(from: .geocode(query: name)).eraseToAnyPublisher()
    }
    
    func deleteLocation(_ id: String) -> AnyPublisher<Bool, any Error> {
        dbService.deleteLocation(id).eraseToAnyPublisher()
    }
}
