//
//  MultipleDayForecast.swift
//  DVT Weather
//
//  Created by Bedan Kimani on 10/01/2025.
//

struct WeekForecast:Codable{
    let city:City
    let list:[CurrentForecast]
}

struct City:Codable {
    let id:Int
    let name:String
    let coord:Coord?
}

struct Coord:Codable {
    let lon:Double
    let lat:Double
}


extension WeekForecast{
    struct Summary:Identifiable{
        let day:String
        let temp:Double
        let weather:String
        let forecast:[CurrentForecast]
        
        var id:String{
            day
        }
    }
    
    //Groups the forecast by weekday, calculating a summary of the day for an overview of the day's weather
    var summary:[Summary]{
        let groups = Dictionary(grouping: list, by: { $0.dt.date.toWeekDay() })
        
        return groups.map{ day, forecast in
            let averageTemperature = forecast.reduce(0){ $0 + $1.main.temp } / Double(forecast.count)
            
            var frequencyDict:[String:Int]  = [:]
            for forecast in forecast {
                frequencyDict[forecast.weather[0].main, default: 0] += 1
            }
            
            let weather = frequencyDict.max(by: { $0.value < $1.value })!.key
            
            return Summary(day: day, temp: averageTemperature, weather: weather, forecast: forecast)
        }
    }
}
