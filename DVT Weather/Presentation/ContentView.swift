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
        TabView {
            WeatherView()
                .tabItem{
                    Label("Weather", systemImage: "cloud.sun.rain")
                }
            
            LocationsView()
                .tabItem {
                    Label("Locations", systemImage: "map")
                }
        }
        .environmentObject(locations)
    }
}

#Preview {
    ContentView()
}
