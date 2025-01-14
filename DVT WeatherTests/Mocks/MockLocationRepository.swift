//
//  MockLocationRepository.swift
//  DVT Weather
//
//  Created by Bedan Kimani on 14/01/2025.
//

@testable import DVT_Weather
import Combine

class MockLocationRepository:LocationRepository {
    
    var locations = Location.samples
    
    func fetchLocations() -> AnyPublisher<[DVT_Weather.Location], any Error> {
        Just(locations).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
    func saveLocation(_ location: DVT_Weather.Location) -> AnyPublisher<DVT_Weather.Location, any Error> {
        locations.append(location)
        return Just(location).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
    func deleteLocation(_ id: String) -> AnyPublisher<Bool, any Error> {
        Just(true).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
    func geoCodeLocation(_ name: String) -> AnyPublisher<DVT_Weather.GeoCodeLocationResultResponse?, any Error> {
        Just(
            GeoCodeLocationResultResponse(results: [
                GeoCodeLocationResult(geometry: Geometry(location: GeometryLocation(lat: 10, lng: 11)))
            ])
        ).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
    
    
    
}
