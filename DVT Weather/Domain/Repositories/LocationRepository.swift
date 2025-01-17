//
//  LocationRepository.swift
//  DVT Weather
//
//  Created by Bedan Kimani on 12/01/2025.
//

import Combine

protocol LocationRepository{
    
    
    func fetchLocations() -> AnyPublisher<[Location], Error>
    
    func saveLocation(_ location: Location) -> AnyPublisher<Location, Error>
    
    func deleteLocation(_ id: String) -> AnyPublisher<Bool, Error>
    
    func geoCodeLocation(_ name: String) -> AnyPublisher<GeoCodeLocationResultResponse?, Error>
    
}
