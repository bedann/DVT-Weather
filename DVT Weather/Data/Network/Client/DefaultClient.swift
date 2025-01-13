//
//  DefaultClient.swift
//  DVT Weather
//
//  Created by Bedan Kimani on 10/01/2025.
//


import Foundation
import Combine
import SwiftUI

class DefaultClient<Endpoint:ApiRequest>:ApiClient{
    
    var forPreview:Bool = false
    
    let offlineCodes:[URLError.Code] = [
        .networkConnectionLost,
        .notConnectedToInternet,
        .cannotConnectToHost,
        .cannotParseResponse
    ]
    
    
    private func buildUrl(from endpoint:Endpoint)->URL{
        var url = endpoint.baseUrl
        url.append(path: endpoint.path)
        
        //Query params
        endpoint.params?.forEach{ key, value in
            url.appendQueryItem(name: key, value: value)
        }
        return url
    }
    
    
    func fetch<T>(from endpoint: Endpoint) -> AnyPublisher<T, Error> where T : Decodable {
        let url = self.buildUrl(from: endpoint)
        
        var request = URLRequest(url: url)
        
        //Headers
        request.allHTTPHeaderFields = endpoint.headers
        
        request.httpMethod = endpoint.method.rawValue
        
        debugPrint("\(endpoint.method.rawValue) \(url.absoluteString)")
        //Body if available
        if let body = endpoint.body{
            request.httpBody = body
        }
        
        if forPreview{
            return Just("").tryMap({ a -> T in
                throw ApiError.offline
            }).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .mapError({[weak self] failure in
                if self?.offlineCodes.contains(failure.code) == true {
                    return ApiError.offline
                }
                return ApiError.custom(failure.localizedDescription)
            })
            .tryMap{ data, response in
                guard let res = response as? HTTPURLResponse else{
                    throw ApiError.invalidResponse
                }
                guard res.statusCode >= 200, res.statusCode < 300 else{
                    if res.statusCode == 401{
                        throw ApiError.unAuthenticated
                    }
                    throw ApiError.invalidResponse
                }
                let string = String(data: data, encoding: .utf8)
//                let jsonData = try JSONSerialization.data(withJSONObject: data)
                let decoder = JSONDecoder()
                do {
                    return try decoder.decode(T.self, from: data)
                } catch{
                    if error is DecodingError{
                        switch error as? DecodingError{
                        case .typeMismatch( _, let context):
                            throw ApiError.typeMispatch(context.codingPath.first?.stringValue ?? "", context.debugDescription)
                        default:
                            let dataAsString = String(data: data, encoding: .utf8)!.replacingOccurrences(of: "\n", with: " ")
                            let jsonData = Data(dataAsString.utf8)
                            return try decoder.decode(T.self, from: jsonData)
                        }
                    }else{
                        throw ApiError.custom(error.localizedDescription)
                    }
                }
            }
            .eraseToAnyPublisher()
        
    }
    
}
