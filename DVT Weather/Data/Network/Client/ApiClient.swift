//
//  ApiClient.swift
//  DVT Weather
//
//  Created by Bedan Kimani on 10/01/2025.
//

import Foundation
import Combine

protocol ApiClient{
    associatedtype Endpoint:ApiRequest
    func fetch<T:Decodable>(from endpoint:Endpoint) -> AnyPublisher<T,Error>
}
