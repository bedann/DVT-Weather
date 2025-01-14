//
//  LocationTests.swift
//  DVT WeatherTests
//
//  Created by Bedan Kimani on 14/01/2025.
//

import XCTest
import Combine
@testable import DVT_Weather

final class LocationTests: XCTestCase {

    
    
    var cancellables: Set<AnyCancellable> = []
    
    override func tearDownWithError() throws {
        cancellables = []
    }
    
    func testLocationCoordsAndWeatherFetched(){
        let sut = AddLocationViewModel(
            locationRepository: MockLocationRepository(),
            weatherRepository: MockWeatherRepository()
        )
        
        let location = Location(id: "sample10", name: "SampleLoc", lat: nil, lon: nil, forecast: [])
        
        let expectation = self.expectation(description: "Forecast loaded")
        var selectedLocation: Location? = nil
        
        sut.$selectedLocaiton
            .dropFirst()
            .sink { location in
                selectedLocation = location
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        sut.fetchSelectedLocationWeather(location: location)
            
        wait(for: [expectation], timeout: 3)
        XCTAssertNotNil(selectedLocation)
        XCTAssertNotNil(selectedLocation?.lat)
        XCTAssertNotNil(selectedLocation?.lon)
        XCTAssertFalse(selectedLocation?.forecast.isEmpty == true)
    }
    
    func testLocationDeleted(){
        let sut = LocationsViewModel(
            repository: MockLocationRepository(),
            weatherRepository: MockWeatherRepository()
        )
        
        sut.locations = Location.samples
        let initialCount = sut.locations.count
        let location = sut.locations.first!
        let expectation = self.expectation(description: "Location deleted")
        
        sut.$locations
            .dropFirst()
            .sink { locations in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        sut.deleteLocation(location: location)
        
        wait(for: [expectation])
        XCTAssertTrue(sut.locations.count < initialCount)
        XCTAssertFalse(sut.locations.contains(where: { $0.id == location.id }))
    }
    
    func testLocationSavedAndUpdated(){
        let sut = LocationsViewModel(
            repository: MockLocationRepository(),
            weatherRepository: MockWeatherRepository()
        )
        
        let location:Location = .init(id: "sampleId2", name: "Sample Location")
        let expectation = self.expectation(description: "Location Saved")
        sut.locations = Location.samples
        let initialCount = sut.locations.count
        
        sut.$locations
            .dropFirst()
            .sink { locations in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        sut.saveLocation(location)
        
        wait(for: [expectation])
        XCTAssertEqual(initialCount, 11)
        XCTAssertEqual(sut.locations.count, 12)
        
    }
    
    func testLocalLocationFetchedWithForecast(){
        
        let sut = SQLDbService(database: .empty())
        
        var location = Location.samples[0]
        var forecast = DayForecast.sample
        forecast.locationId = location.id
        
        let saved = self.expectation(description: "Forecast and Location Saved")
        var locationForecast:LocationForecast? = nil
        
        sut.saveForecast(forecast)
            .flatMap{ _ in
                sut.saveLocation(LocationEntity.from(location))
            }
            .sink { completion in
                
            } receiveValue: { entity in
                if let entity {
                    saved.fulfill()
                }
            }
            .store(in: &cancellables)
        
        wait(for: [saved])
        
        let retrieved = self.expectation(description: "Location retrieved")
        
        sut.fetchLocations()
            .sink { completion in
                
            } receiveValue: { locations in
                locationForecast = locations.first
                retrieved.fulfill()
            }
            .store(in: &cancellables)
        
        wait(for: [retrieved])
        
        XCTAssertEqual(locationForecast?.forecast?.first?.locationId, location.id)
        XCTAssertEqual(locationForecast?.location.id, location.id)
    }

}
