//
//  NetworkExtensions.swift
//  DVT Weather
//
//  Created by Bedan Kimani on 10/01/2025.
//
import Foundation

extension URL {

    mutating func appendQueryItem(name: String, value: String?) {

        guard var urlComponents = URLComponents(string: absoluteString) else { return }

        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []

        let queryItem = URLQueryItem(name: name, value: value)

        queryItems.append(queryItem)

        urlComponents.queryItems = queryItems

        self = urlComponents.url!
    }
}



extension Error{
    var isOfflineError:Bool{
        if let error = self as? ApiError, error == .offline{
            return true
        }
        return false
    }
}
