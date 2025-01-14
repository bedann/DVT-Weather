//
//  DayForecast+Samples.swift
//  DVT Weather
//
//  Created by Bedan Kimani on 14/01/2025.
//
import Foundation

extension DayForecast{
    
    static var sample: DayForecast{
        DayForecast(
            currentForecast: CurrentForecast.sample,
            weekForecast: WeekForecast(
                city: City(id: 1, name: "Kiambu", coord: Coord(lon: 0, lat: 0)),
                list: [
                    CurrentForecast.sample
                ]
            ),
            location: "Kiambu",
            locationId: "kiambu1"
        )
    }
    
}


extension CurrentForecast{
    
    static var sample: CurrentForecast{
        CurrentForecast(
            dt: Date().timeIntervalSince1970,
            main: Main(
                temp: 20,
                temp_min: 18,
                temp_max: 22,
                pressure: 1013,
                humidity: 80
            ),
            weather: [
                Weather(
                    id: 10,
                    main: "Clouds",
                    description: "Partly cloudy",
                    icon: "10d"
                )
            ],
            name: "Kiambu"
        )
    }
}
