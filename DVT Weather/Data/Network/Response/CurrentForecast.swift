//
//  SingleForecast.swift
//  DVT Weather
//
//  Created by Bedan Kimani on 10/01/2025.
//

struct CurrentForecast:Codable {
    let dt:Int64
    let main:Main
    let weather:[Weather]
    let name:String
    let id:Int
}

struct Weather:Codable {
    let id:Int
    let main:String
    let description:String
    let icon:String
}

struct Main:Codable {
    let temp:Double
    let temp_min:Double
    let temp_max:Double
    let pressure:Double
    let humidity:Double
}

