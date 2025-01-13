//
//  LocationsApi.swift
//  DVT Weather
//
//  Created by Bedan Kimani on 13/01/2025.
//


import Foundation

enum LocationsApi:ApiRequest{
    case geocode(query:String)
    
    
    var baseUrl: URL{
        URL(string: "https://maps.googleapis.com/maps/api/")!
    }
    
    var path: String{
        switch self{
        case .geocode:
            "geocode/json"
        }
    }
    
    var method: HttpMethod{
        switch self{
        default:
            .get
        }
    }
    
    var params: [String : String]?{
        switch self{
        case .geocode(let query):
            [
                "address": query,
                "key": apiKey
            ]
        }
    }
    
    private var apiKey: String{
        do{
            return try Configuration.value(for: "PLACES_API_KEY")
        }catch{
            print("Missing PLACES_API_KEY in config file")
            return ""
        }
    }
    
    var body: Data?{
        switch self{
        default:
            nil
        }
    }
    
    var headers: [String : String]{
        [:]
    }
    
    
}
