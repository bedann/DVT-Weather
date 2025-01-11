//
//  DayForecast+Persistence.swift
//  DVT Weather
//
//  Created by Bedan Kimani on 10/01/2025.
//

import GRDB
import Foundation

extension DayForecast:FetchableRecord, PersistableRecord {
    
    static var databaseTableName: String = "forecast"
    
    static let location = belongsTo(LocationEntity.self, using: ForeignKey(["locationId"])).forKey("location")
    
}
