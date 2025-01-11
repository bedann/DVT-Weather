//
//  WeatherView.swift
//  DVT Weather
//
//  Created by Bedan Kimani on 10/01/2025.
//

import SwiftUI


struct WeatherView:View {
    
    @StateObject var viewModel = WeatherViewModel()
    
    var body: some View {
        GeometryReader{ proxy in
            VStack(spacing: 0){
                CurrentView(
                    currentForecast: viewModel.forecast?.currentForecast,
                    width: proxy.size.width,
                    topSafeArea: proxy.safeAreaInsets.top
                )
                WeeklyView(
                    forecast: viewModel.forecast
                )
            }
            .background(Color(viewModel.forecast?.currentForecast?.resourceId ?? "cloudy"))
        }
    }
    
}






#Preview {
    ContentView()
}
