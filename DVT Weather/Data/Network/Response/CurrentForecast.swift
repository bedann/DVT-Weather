//
//  SingleForecast.swift
//  DVT Weather
//
//  Created by Bedan Kimani on 10/01/2025.
//

struct CurrentForecast:Codable,Identifiable {
    let dt:Double
    let main:Main
    let weather:[Weather]
    let name:String?
    
    var id:Double{
        dt
    }
}

struct Weather:Codable {
    let id:Int
    let main:String
    let description:String
    let icon:String
}

struct Main:Codable {
    let temp:Double
    let temp_min:Double
    let temp_max:Double
    let pressure:Double
    let humidity:Double
}

extension CurrentForecast{
    
    var resourceId:String{
        switch weather.first?.main ?? ""{
        case let x where x.localizedCaseInsensitiveContains("rain"):
            "rainy"
        case let x where x.localizedCaseInsensitiveContains("cloud"):
            "cloudy"
        default:
            "sunny"
        }
    }
    
    var icon:String{
        return CurrentForecast.iconResource(for: weather.first?.main ?? "")
    }
    
    static func iconResource(for name:String)->String{
        switch name{
        case let x where x.localizedCaseInsensitiveContains("rain"):
            "rain"
        case let x where x.localizedCaseInsensitiveContains("cloud"):
            "partlysunny"
        default:
            "clear"
        }
    }
    
}
