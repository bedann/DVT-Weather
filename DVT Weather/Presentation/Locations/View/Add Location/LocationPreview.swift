//
//  LocationPreview.swift
//  DVT Weather
//
//  Created by Bedan Kimani on 13/01/2025.
//
import SwiftUI

struct LocationPreview:View {
    
    let location:Location
    let onSave:(Location)->Void
    @EnvironmentObject var viewModel:AddLocationViewModel
    
    
    var body: some View {
        VStack(alignment: .center){
            if let location = viewModel.selectedLocaiton{
                LocationCard(location: location, current: true)
            }
            if viewModel.loading{
                ProgressView()
            }
            Spacer()
            PrimaryButton(text: "SAVE LOCATION", action: {
                viewModel.saveLocation {
                    onSave($0)
                }
            })
        }
        .padding()
        .onAppear{
            viewModel.fetchSelectedLocationWeather(location: location)
        }
    }
}

#Preview {
    LocationPreview(location: .init()){ _ in
        
    }
}
