//
//  SQLDbService.swift
//  DVT Weather
//
//  Created by Bedan Kimani on 10/01/2025.
//
import Foundation
import Combine
import GRDB

class SQLDbService:DBService {
    
    let database:AppDatabase
    
    init(database: AppDatabase) {
        self.database = database
    }
    
    func loadForecast(for locationId: String?) -> AnyPublisher<DayForecast?,Error> {
        return database.getDb().readPublisher { db in
            return try DayForecast.fetchOne(
                db,
                sql: "SELECT * FROM \(DayForecast.databaseTableName) WHERE locationId = ? ORDER BY date DESC LIMIT 1",
                arguments: [locationId]
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
    
    
    func fetchLocations() -> AnyPublisher<[LocationForecast], any Error> {
        return database.getDb().readPublisher { db in
            return try LocationEntity
                .including(all: LocationEntity.forecast.order(Column("date").desc))
                .asRequest(of: LocationForecast.self)
                .fetchAll(db)
        }
        .eraseToAnyPublisher()
    }
    
    func saveLocation(_ location: LocationEntity) -> AnyPublisher<LocationEntity?, Error> {
        return database.getDb().writePublisher { db in
            try location.saved(db, onConflict: .replace)
        }
        .eraseToAnyPublisher()
    }
    
    func deleteLocation(_ id: String) -> AnyPublisher<Bool, any Error> {
        return database.getDb().writePublisher { db in
            try LocationEntity.deleteOne(db, key: id)
        }
        .eraseToAnyPublisher()
    }
    
    
}
