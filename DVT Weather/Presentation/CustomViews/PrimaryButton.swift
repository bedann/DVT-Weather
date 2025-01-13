//
//  PrimaryButton.swift
//  DVT Weather
//
//  Created by Bedan Kimani on 13/01/2025.
//
import SwiftUI

struct PrimaryButton: View {
    
    let text:String
    let action:()->Void
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.headline)
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity, alignment: .center)
                .background(Color.tertiarySystemBackground)
                .cornerRadius(10)
        }
    }
}


#Preview {
    PrimaryButton(text: "Action", action: {})
}
