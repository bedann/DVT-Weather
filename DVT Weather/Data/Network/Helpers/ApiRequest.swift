//
//  ApiRequest.swift
//  DVT Weather
//
//  Created by Bedan Kimani on 10/01/2025.
//

import Foundation

protocol ApiRequest{
    
    var baseUrl:URL { get }
    
    var path:String { get }
    
    var method:HttpMethod { get }
    
    var params:[String:String]? { get }
    
    var body:Data? { get }
    
    var headers:[String:String] { get }
    
    
}

extension ApiRequest{
    
    var defaultBaseUrl:URL{
        return URL(string: "https://api.openweathermap.org/data/2.5/")!
    }
    
    var defaultHeaders:[String:String]{
        return [
            "Accept": "application/json",
            "Content-Type": "application/json",
        ]
    }
    
}
