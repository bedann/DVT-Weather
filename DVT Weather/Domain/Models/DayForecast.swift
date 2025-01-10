//
//  Untitled.swift
//  DVT Weather
//
//  Created by Bedan Kimani on 10/01/2025.
//
import Foundation

struct DayForecast:Codable{
    var date: Date = Date()
    var currentForecast: CurrentForecast? = nil
    var weekForecast: WeekForecast? = nil
    var location:String? = nil
    var locationId:Int? = nil
    var lastUpdate:Date = Date()
}
