//
//  LocationSearchView.swift
//  DVT Weather
//
//  Created by Bedan Kimani on 13/01/2025.
//

import SwiftUI

struct LocationSearchView:View {
    
    let onLocationSaved:(Location)->Void
    @StateObject var viewModel = AddLocationViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack{
            List{
                if viewModel.loading{
                    ProgressView()
                }
                if let error = viewModel.error{
                    Text(error)
                        .foregroundStyle(.red)
                }
                ForEach(viewModel.locations){ location in
                    NavigationLink(destination: LocationPreview(location: location){ location in
                        onLocationSaved(location)
                        dismiss()
                    }.environmentObject(viewModel)){
                        VStack(alignment: .leading){
                            Text(location.name ?? "")
                                .fontWeight(.bold)
                            Text(location.fullAddress ?? "")
                                .font(.subheadline)
                        }
                    }
                }
            }
            .searchable(text: $viewModel.searchTerm)
            .navigationTitle("Search Location")
        }
    }
}

#Preview {
    LocationSearchView(){ _ in
        
    }
}
