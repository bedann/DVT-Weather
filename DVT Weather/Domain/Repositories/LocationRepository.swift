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
    
}
