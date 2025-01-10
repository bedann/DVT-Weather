//
//  ContentView.swift
//  DVT Weather
//
//  Created by Bedan Kimani on 10/01/2025.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            WeatherView()
                .tabItem{
                    Label("Weather", systemImage: "cloud.sun.rain")
                }
            
            VStack(){}
                .tabItem {
                    Label("Locations", systemImage: "map")
                }
        }
    }
}

#Preview {
    ContentView()
}
