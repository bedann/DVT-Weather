//
//  WeatherApi.swift
//  DVT Weather
//
//  Created by Bedan Kimani on 10/01/2025.
//


import Foundation

enum WeatherApi:ApiRequest{
    case getCurrent(lat:Double, lon:Double)
    case getForecast(lat:Double, lon:Double)
    
    
    var baseUrl: URL{
        defaultBaseUrl
    }
    
    var path: String{
        switch self{
        case .getCurrent:
            "weather"
        case .getForecast:
            "forecast"
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
        case
            .getCurrent(let lat, let lon),
            .getForecast(let lat, let lon):
            ["lat":String(lat), "lon":String(lon), "appid": apiKey]
        }
    }
    
    private var apiKey: String{
        do{
            return try Configuration.value(for: "WEATHER_API_KEY")
        }catch{
            print("Missing WEATHER_API_KEY in config file")
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
        defaultHeaders
    }
    
    
}
