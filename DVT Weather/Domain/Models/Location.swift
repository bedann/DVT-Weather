//
//  Location.swift
//  DVT Weather
//
//  Created by Bedan Kimani on 12/01/2025.
//
import Foundation

struct Location: Codable, Identifiable,Equatable{
    var id:String? = nil
    var name:String? = nil
    var fullAddress:String? = nil
    var lat:Double? = nil
    var lon:Double? = nil
    
    var forecast:[DayForecast] = []
}


