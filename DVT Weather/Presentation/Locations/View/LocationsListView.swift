//
//  LocationsListView.swift
//  DVT Weather
//
//  Created by Bedan Kimani on 11/01/2025.
//

import SwiftUI
import Foundation

struct LocationsListView: View {
    
    @EnvironmentObject var locations: LocationsViewModel
    
    var body: some View {
        List{
            
            if let myLocation = locations.myLocation {
                LocationCard(location: myLocation, current: true)
                    .listRowSeparator(.hidden)
                if !locations.isCurrentLocationSaved {
                    Button("Save Current Location"){
                        locations.saveLocation(myLocation)
                    }
                }
            }
            
            Text("Other Locations")
                .listRowSeparator(.hidden)
            
            ForEach(locations.locations){ location in
                LocationCard(location: location)
            }
            .onDelete(perform: {_ in })
        }
        .listStyle(.plain)
    }
    
    
}


struct LocationCard: View {
    
    let location: Location
    var current:Bool
    let forecast:DayForecast?
    
    init(location: Location, current: Bool = false) {
        self.location = location
        self.current = current
        self.forecast = location.forecast.first
    }
    
    var body: some View {
        HStack(spacing: 16){
            
            if let forecast, let icon = forecast.currentForecast?.icon {
                Image(icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
            }
            
            
            VStack(alignment: .leading){
                Text(location.name ?? "")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text(location.fullAddress ?? "")
                    .font(.caption)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            if let forecast{
                VStack{
                    TemperatureText(value: forecast.currentForecast?.main.temp.celcius ?? 0.0)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text(forecast.currentForecast?.weather[0].main.uppercased() ?? "")
                        .font(.caption2)
                }
            }
        }
        .padding()
        .background(Material.ultraThick.opacity(current ? 1 : 0), in: .rect(cornerRadius: 8))
    }
}


#Preview {
    LocationsListView()
}
