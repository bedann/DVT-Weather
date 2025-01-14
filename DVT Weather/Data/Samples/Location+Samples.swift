//
//  Location+Samples.swift
//  DVT Weather
//
//  Created by Bedan Kimani on 14/01/2025.
//

extension Location{
    
    static var samples: [Location] {
        (0..<11).map{ _ in
            Location(
                id: Int.random(in: 1...1000).description,
                name: "Location \(Int.random(in: 1...1000))",
                fullAddress: "Location \(Int.random(in: 1...1000)), \(Int.random(in: 1...1000)) Avenue",
                lat: 2,
                lon: 1,
                forecast: [.sample]
            )
        }
    }
    
}
