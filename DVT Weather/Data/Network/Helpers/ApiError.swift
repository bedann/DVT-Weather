//
//  ApiError.swift
//  DVT Weather
//
//  Created by Bedan Kimani on 10/01/2025.
//


import Foundation

enum ApiError:LocalizedError, Equatable{
    case invalidUrl
    case invalidResponse
    case unAuthenticated
    case custom(String)
    case typeMispatch(String,String)
    case offline;
    
    var errorDescription: String?{
        switch self{
        case.invalidUrl:
            "Invalid URL"
        case .invalidResponse:
            "Invalid Response"
        case .unAuthenticated:
            "Unauthenticated or expired token"
        case .custom(let msg):
            msg
        case .typeMispatch(let field, _):
            "Type mismatch for \(field)."
        case .offline:
            "The Internet connection appears to be offline."
        }
    }
}
