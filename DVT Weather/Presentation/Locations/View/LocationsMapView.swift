//
//  LocationsMapView.swift
//  DVT Weather
//
//  Created by Bedan Kimani on 11/01/2025.
//

import SwiftUI
import Foundation
import MapKit

struct LocationsMapView: View {

    
    @EnvironmentObject var locations:LocationsViewModel
    
    
    var body: some View {
        Map{
            ForEach(locations.locations){ location in
                Marker(location.name ?? "", coordinate: location.coordinate)
                    .tag(location.id)
                Annotation(location.name ?? "", coordinate: location.coordinate, anchor: .top){
                    weatherAnnotation(location: location)
                        .onTapGesture {
                            locations.mainTab = 0
                            locations.selectedLocation = location
                        }
                }
                    .tag(location.id)
                
            }
        }
        .mapStyle(.hybrid)
    }
    
    func weatherAnnotation(location:Location) -> some View {
        HStack{
            if let forecast = location.forecast.first?.currentForecast{
                Image(forecast.icon)
                    .resizable()
                    .frame(width: 32, height: 32)
                VStack{
                    Text(forecast.weather[safe: 0]?.main.uppercased() ?? "")
                        .font(.caption2)
                    TemperatureText(value: forecast.main.temp.celcius)
                        .font(.caption)
                }
            }else{
                Text("??")
            }
        }
        .padding(4)
        .background(Color(location.forecast.first?.currentForecast?.resourceId ?? "cloudy"), in: .rect(cornerRadius: 8))
        .contentShape(.rect)
    }
}

#Preview {
    LocationsMapView()
}
