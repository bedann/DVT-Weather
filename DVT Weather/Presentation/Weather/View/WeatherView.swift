//
//  WeatherView.swift
//  DVT Weather
//
//  Created by Bedan Kimani on 10/01/2025.
//

import SwiftUI


struct WeatherView:View {
    
    @StateObject var weather = WeatherViewModel()
    @EnvironmentObject var locations:LocationsViewModel
    
    var body: some View {
        GeometryReader{ proxy in
            VStack(spacing: 0){
                CurrentView(
                    currentForecast: weather.forecast?.currentForecast,
                    width: proxy.size.width,
                    topSafeArea: proxy.safeAreaInsets.top
                )
                WeeklyView(
                    forecast: weather.forecast
                )
                
                Text(locations.selectedLocation?.name ?? "--")
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding(.bottom)
            }
            .background(Color(weather.forecast?.currentForecast?.resourceId ?? "cloudy"))
        }
        .onChange(of: locations.selectedLocation) { oldValue, newValue in
            if let newValue, newValue.id != oldValue?.id {
                weather.fetchForecast(location: newValue)
            }
        }
    }
    
}






#Preview {
    ContentView()
}
