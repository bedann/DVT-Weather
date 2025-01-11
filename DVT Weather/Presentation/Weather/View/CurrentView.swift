//
//  CurrentView.swift
//  DVT Weather
//
//  Created by Bedan Kimani on 10/01/2025.
//
import SwiftUI

struct CurrentView:View {
    
    let currentForecast:CurrentForecast?
    let width:CGFloat
    let topSafeArea:CGFloat
    
    var body: some View {
        VStack(){
            if let currentForecast{
                TemperatureText(value: currentForecast.main.temp.celcius)
                    .font(.system(size: 70, weight: .regular))
                
                Text(currentForecast.weather[safe: 0]?.main.uppercased() ?? "")
                    .font(.title)
            }
        }
        .foregroundStyle(.white)
        .padding()
        .frame(maxWidth: .infinity, minHeight: (width * 0.86) - topSafeArea, alignment: .top)
        .background{
            Image("sea_\(currentForecast?.resourceId ?? "cloudy")")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea(edges: .all)
        }
    }
}


#Preview {
    WeatherView()
}
