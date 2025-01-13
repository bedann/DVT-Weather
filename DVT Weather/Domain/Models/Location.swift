//
//  Location.swift
//  DVT Weather
//
//  Created by Bedan Kimani on 12/01/2025.
//
import Foundation
import MapKit

struct Location: Codable, Identifiable,Equatable{
    var id:String? = nil
    var name:String? = nil
    var fullAddress:String? = nil
    var lat:Double? = nil
    var lon:Double? = nil
    
    var forecast:[DayForecast] = []
}


extension Location{
    
    var coordinate:CLLocationCoordinate2D{
        .init(latitude:lat ?? 0, longitude:lon ?? 0)
    }
    
}
