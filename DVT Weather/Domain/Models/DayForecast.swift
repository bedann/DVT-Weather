//
//  Untitled.swift
//  DVT Weather
//
//  Created by Bedan Kimani on 10/01/2025.
//
import Foundation

struct DayForecast:Codable,Equatable{
    var date: Date = Date()
    var currentForecast: CurrentForecast? = nil
    var weekForecast: WeekForecast? = nil
    var location:String? = nil
    var locationId:String? = nil
    var lastUpdate:Date = Date()
    
    
    static func == (lhs: DayForecast, rhs: DayForecast) -> Bool {
        lhs.date == rhs.date && lhs.locationId == rhs.locationId
    }
}
