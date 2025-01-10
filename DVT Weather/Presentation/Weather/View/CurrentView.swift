//
//  CurrentView.swift
//  DVT Weather
//
//  Created by Bedan Kimani on 10/01/2025.
//
import SwiftUI

struct CurrentView:View {
    
    let width:CGFloat
    let topSafeArea:CGFloat
    
    var body: some View {
        VStack(){
            Text(Measurement(value: 18, unit: UnitTemperature.celsius), format: .measurement(width: .narrow))
                .font(.system(size: 70, weight: .regular))
            
            Text("CLOUDY")
                .font(.title)
            
        }
        .foregroundStyle(.white)
        .padding()
        .frame(maxWidth: .infinity, minHeight: (width * 0.86) - topSafeArea, alignment: .top)
        .background{
            Image("sea_cloudy")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea(edges: .all)
        }
    }
}


#Preview {
    WeatherView()
}
