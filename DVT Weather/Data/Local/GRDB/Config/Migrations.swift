//
//  Migrations.swift
//  DVT Weather
//
//  Created by Bedan Kimani on 10/01/2025.
//

import Foundation
import GRDB

extension AppDatabase{
    
    var migrator:DatabaseMigrator{
        var migrator = DatabaseMigrator()
        #if DEBUG
        migrator.eraseDatabaseOnSchemaChange = true
        #endif
        
        migrator.registerMigration("1.0") { db in
            try createLocationsTable(db)
            try createWeatherTable(db)
        }
        
        
        return migrator
    }
    
    private func createWeatherTable(_ db: Database) throws{
        try db.create(table: DayForecast.databaseTableName) { t in
            t.column("date", .date)
            t.column("lastUpdate", .datetime)
            t.column("currentForecast", .jsonText)
            t.column("weekForecast", .jsonText)
            t.column("location", .text)
            t.column("locationId", .jsonText)
            t.primaryKey(["date", "locationId"])
        }
    }
    
    private func createLocationsTable(_ db: Database) throws{
        try db.create(table: LocationEntity.databaseTableName) { t in
            t.column("id", .text).primaryKey(onConflict: .replace)
            t.column("name", .text)
            t.column("fullAddress", .text)
            t.column("lat", .double)
            t.column("lon", .double)
        }
    }
    
}
    
