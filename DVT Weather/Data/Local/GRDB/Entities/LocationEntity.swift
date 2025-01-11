//
//  FavoriteLocation.swift
//  DVT Weather
//
//  Created by Bedan Kimani on 11/01/2025.
//

import Foundation
import GRDB

struct LocationEntity: Codable, FetchableRecord, PersistableRecord {
    var id:String? = nil
    var name:String? = nil
    var fullAddress:String? = nil
    var lat:Double? = nil
    var lon:Double? = nil
}


extension LocationEntity{
    static var databaseTableName: String = "locations"
    
    static let forecast = hasMany(DayForecast.self, using: ForeignKey(["locationId"])).forKey("forecast")
}


extension LocationEntity{
    
    static func from(_ location: Location) -> LocationEntity{
        LocationEntity(id: location.id, name: location.name, fullAddress: location.fullAddress, lat: location.lat, lon: location.lon)
    }
    
    func toDomainLocation() -> Location{
        .init(id: id, name: name, fullAddress: fullAddress, lat: lat, lon: lon)
    }
    
}
