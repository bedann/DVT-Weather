//
//  SQLDbService.swift
//  DVT Weather
//
//  Created by Bedan Kimani on 10/01/2025.
//
import Foundation
import Combine

class SQLDbService:DBService {
    
    let database:AppDatabase
    
    init(database: AppDatabase) {
        self.database = database
    }
    
    func loadForecast(for cityId: Int?) -> AnyPublisher<DayForecast?,Error> {
        return database.getDb().readPublisher { db in
            return try DayForecast.fetchOne(
                db,
                sql: "SELECT * FROM \(DayForecast.databaseTableName) WHERE locationId = ? ORDER BY date DESC LIMIT 1",
                arguments: [cityId]
            )
        }
        .eraseToAnyPublisher()
    }
    
    func saveForecast(_ forecast: DayForecast) -> AnyPublisher<DayForecast?, Error> {
        return database.getDb().writePublisher { db in
            return try forecast.insertAndFetch(db, onConflict: .replace)
        }
        .eraseToAnyPublisher()
    }
    
    
    
}
