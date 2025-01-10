//
//  AppDatabase.swift
//  DVT Weather
//
//  Created by Bedan Kimani on 10/01/2025.
//

import Foundation
import GRDB
import Combine

struct AppDatabase{
    
    private let dbWriter: any DatabaseWriter
    
    init(_ dbWriter: any DatabaseWriter) throws {
        self.dbWriter = dbWriter
        try migrator.migrate(dbWriter)
    }
    
    func getDb() -> DatabaseWriter{
        dbWriter
    }
}


extension AppDatabase{
    
    static let shared = makeShared()
    
    private static func makeShared() -> AppDatabase{
        do{
            let fileManager = FileManager.default
            let appSupportURL = try fileManager.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let directoryURL = appSupportURL.appendingPathComponent("DVT Database", isDirectory: true)
            try fileManager.createDirectory(at: directoryURL, withIntermediateDirectories: true)
            let databaseURL = directoryURL.appendingPathComponent("db.sqlite")

            let dbPool = try DatabasePool(path: databaseURL.path, configuration: .init())
            let appDatabase = try AppDatabase(dbPool)
            
            return appDatabase
        }catch{
            fatalError("Unresolved error \(error)")
        }
    }
    
    /// Creates an empty in-memory database for SwiftUI previews and tests
    static func empty() -> AppDatabase {
        let dbQueue = try! DatabaseQueue(configuration: .init())
        return try! AppDatabase(dbQueue)
    }
    
}
