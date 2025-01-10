//
//  WeeklyView.swift
//  DVT Weather
//
//  Created by Bedan Kimani on 10/01/2025.
//

import SwiftUI

struct WeeklyView:View {
    
    var body: some View {
        VStack{
            HStack{
                tempColumn(key: "min", value: 16)
                tempColumn(key: "Current", value: 18)
                tempColumn(key: "max", value: 23)
            }
            
            Color.white.frame(height: 1)
            
            ScrollView(.vertical){
                VStack(spacing: 16){
                    
                    dayRow()
                    dayRow()
                    dayRow()
                    dayRow()
                    dayRow()
                    dayRow()
                    dayRow()
                    dayRow()
                    
                }
            }
        }
        .padding(.top)
    }
    
    func tempColumn(key:String, value:Double) -> some View {
        VStack{
            Text(Measurement(value: value, unit: UnitTemperature.celsius), format: .measurement(width: .narrow))
            Text(key)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity)
    }
    
    func dayRow() -> some View {
        HStack{
            Text("Tuesday")
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Image("rain")
                .resizable()
                .frame(width: 30, height: 30)
            
            Text(Measurement(value: 20, unit: UnitTemperature.celsius), format: .measurement(width: .narrow))
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .foregroundStyle(.white)
        .padding(.horizontal)
    }
}



#Preview {
    WeatherView()
}
