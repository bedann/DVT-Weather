//
//  WeatherView.swift
//  DVT Weather
//
//  Created by Bedan Kimani on 10/01/2025.
//

import SwiftUI


struct WeatherView:View {
    
    var body: some View {
        GeometryReader{ proxy in
            VStack(spacing: 0){
                CurrentView(width: proxy.size.width, topSafeArea: proxy.safeAreaInsets.top)
                WeeklyView()
            }
            .background(Color("cloudy"))
        }
    }
    
}






#Preview {
    ContentView()
}
