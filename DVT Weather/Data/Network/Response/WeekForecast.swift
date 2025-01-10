//
//  MultipleDayForecast.swift
//  DVT Weather
//
//  Created by Bedan Kimani on 10/01/2025.
//

struct WeekForecast:Codable{
    let city:City?
    let list:[CurrentForecast]
}

struct City:Codable {
    let name:String
    let coord:Coord?
}

struct Coord:Codable {
    let lon:Double
    let lat:Double
}
