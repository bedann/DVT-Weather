//
//  LocationForecast.swift
//  DVT Weather
//
//  Created by Bedan Kimani on 12/01/2025.
//
import GRDB

struct LocationForecast:Decodable,FetchableRecord{
    var location:LocationEntity
    var forecast:[DayForecast]?
}
