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
                Text("My current location")
                    .font(.caption)
                    .listRowSeparator(.hidden)
                LocationCard(location: myLocation, current: true)
                    .listRowSeparator(.hidden)
                    .contentShape(.rect)
                    .onTapGesture {
                        locations.mainTab = 0
                        locations.selectedLocation = myLocation
                    }
                if !locations.isCurrentLocationSaved {
                    PrimaryButton(text: "Save Current Location"){
                        locations.saveLocation(myLocation)
                    }
                    .buttonStyle(.plain)
                }
            }
            
            if !locations.locations.isEmpty{
                Text("Other Locations")
                    .font(.caption)
                    .listRowSeparator(.hidden)
            }
            
            ForEach(locations.locations.filter({ $0.id != locations.myLocation?.id })){ location in
                LocationCard(location: location)
                    .contentShape(.rect)
                    .onTapGesture {
                        withAnimation{
                            locations.mainTab = 0
                            locations.selectedLocation = location
                        }
                    }
            }
            .onDelete { indexSet in
                if let index = indexSet.first{
                    locations.deleteLocation(location: locations.locations[index])
                }
            }
            
            if locations.locations.isEmpty{
                Image("empty_locations")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(Color.placeholderText)
                    .frame(width: 100, height: 100)
                    .listRowSeparator(.hidden)
            }else{
                Text("Swipe left to delete")
                    .font(.caption)
                    .opacity(0.5)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top)
                    .listRowSeparator(.hidden)
            }
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
