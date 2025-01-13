//
//  ContentView.swift
//  DVT Weather
//
//  Created by Bedan Kimani on 10/01/2025.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var locations = LocationsViewModel()
    
    var body: some View {
        TabView(selection: $locations.mainTab) {
            WeatherView()
                .tag(0)
                .tabItem{
                    Label("Weather", systemImage: "cloud.sun.rain")
                }
            
            LocationsView()
                .tabItem {
                    Label("Locations", systemImage: "map")
                }
                .tag(1)
        }
        .environmentObject(locations)
    }
}

#Preview {
    ContentView()
}
