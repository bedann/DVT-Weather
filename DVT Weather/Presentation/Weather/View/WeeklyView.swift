//
//  WeeklyView.swift
//  DVT Weather
//
//  Created by Bedan Kimani on 10/01/2025.
//

import SwiftUI

struct WeeklyView:View {
    
    let forecast:DayForecast?
    
    var body: some View {
        VStack{
            if let current = forecast?.currentForecast{
                HStack{
                    tempColumn(key: "min", value: current.main.temp_min.celcius)
                    tempColumn(key: "Current", value: current.main.temp.celcius)
                    tempColumn(key: "max", value: current.main.temp_max.celcius)
                }
            }
            
            Color.white.frame(height: 1)
            
            ScrollView(.vertical){
                VStack(spacing: 16){
                    
                    if let weekForecast = forecast?.weekForecast?.summary{
                        ForEach(weekForecast){ daySummary in
                            DaySummaryView(summary: daySummary)
                                .transition(.slide)
                        }
                    }
                    
                }
            }
        }
        .padding(.top)
    }
    
    func tempColumn(key:String, value:Double) -> some View {
        VStack{
            TemperatureText(value: value)
            Text(key)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity)
        .foregroundStyle(.white)
    }
}

struct DaySummaryView:View {
    
    let summary:WeekForecast.Summary
    @State var expanded:Bool = false
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "chevron.right")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 12, height: 12)
                    .rotationEffect(expanded ? .degrees(90) : .degrees(0))
                
                Text(summary.day)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Image(CurrentForecast.iconResource(for: summary.weather))
                    .resizable()
                    .frame(width: 32, height: 32)
                
                TemperatureText(value: summary.temp.celcius)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .foregroundStyle(.white)
            if expanded{
                ForEach(summary.forecast){ forecast in
                    timeRow(forecast: forecast)
                }
            }
        }
        .contentShape(.rect)
        .onTapGesture {
            withAnimation(.spring(duration: 0.6, bounce: 0.3)){
                self.expanded.toggle()
            }
        }
        .padding(.horizontal)
        .background(Material.ultraThin.opacity(expanded ? 1 : 0))
    }
    
    
    func timeRow(forecast:CurrentForecast) -> some View {
        HStack{
            Text(forecast.dt.date.toTime())
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.caption)
            
            Image(forecast.icon)
                .resizable()
                .frame(width: 24, height: 24)
            
            TemperatureText(value: forecast.main.temp.celcius)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .foregroundStyle(.white)
        .padding(.leading, 16)
    }
    
}

#Preview {
    WeatherView()
}
