//
//  TempText.swift
//  DVT Weather
//
//  Created by Bedan Kimani on 11/01/2025.
//
import SwiftUI

struct TemperatureText:View {
    
    let value: Double
    
    var body: some View {
        Text(
            Measurement(
                value: value,
                unit: UnitTemperature.celsius
            ),
            format: .measurement(
                width: .narrow,
                numberFormatStyle: .number.precision(.fractionLength(0))
            )
        )
    }
    
}
