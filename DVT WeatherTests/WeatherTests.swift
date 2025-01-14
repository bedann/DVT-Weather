//
//  WeatherTests.swift
//  DVT WeatherTests
//
//  Created by Bedan Kimani on 14/01/2025.
//

import XCTest
@testable import DVT_Weather
import Combine

final class WeatherTests: XCTestCase {
    
    var cancellables: Set<AnyCancellable> = []
    
    override func tearDownWithError() throws {
        cancellables = []
    }
    

    func testLocationValidationFailure() throws {
        let sut = WeatherViewModel(repository: MockWeatherRepository())
        
        let expectation = self.expectation(description: "Location validation error")
        var error:String? = nil
        
        sut.$error
            .dropFirst()
            .sink { er in
                error = er
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        sut.fetchForecast(location: .init())
        
        wait(for: [expectation])
        XCTAssertEqual(error, "Invalid location")
    }
    

    func testLocationValidationSuccess() throws {
        let sut = WeatherViewModel(repository: MockWeatherRepository())
        
        let expectation = self.expectation(description: "Forecast successfully loaded")
        var forecast:DayForecast? = nil
        
        sut.$forecast
            .dropFirst()
            .sink { res in
                forecast = res
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        sut.fetchForecast(location: Location(id: "sampleId", name: "Kiambu", lat: 2, lon: 1))
        
        wait(for: [expectation])
        XCTAssertNil(sut.error)
        XCTAssertNotNil(forecast)
        XCTAssertEqual(forecast?.locationId, "sampleId")
    }

}
