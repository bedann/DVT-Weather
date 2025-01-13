//
//  GeoCodeLocationResult.swift
//  DVT Weather
//
//  Created by Bedan Kimani on 13/01/2025.
//

struct GeoCodeLocationResultResponse:Codable{
    let results:[GeoCodeLocationResult]
}

struct GeoCodeLocationResult:Codable{
    let geometry:Geometry
}

struct Geometry:Codable{
    let location:GeometryLocation
}

struct GeometryLocation:Codable{
    let lat:Double
    let lng:Double
}
