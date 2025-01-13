//
//  LocationsView.swift
//  DVT Weather
//
//  Created by Bedan Kimani on 10/01/2025.
//

import SwiftUI

struct LocationsView:View {
    
    @State var selectedViewType:String = "Map"
    @State var showAddLocation = false
    @EnvironmentObject var locations:LocationsViewModel
    
    public var body: some View {
        NavigationStack{
            ZStack(alignment: .top){
                
                if selectedViewType == "List"{
                    LocationsListView()
                        .padding(.top, 50)
                }else{
                    LocationsMapView()
                }
                
                Picker("View Type", selection: $selectedViewType){
                    ForEach(["Map", "List"], id: \.self){
                        Text($0)
                            .tag($0)
                    }
                    
                }
                .pickerStyle(.segmented)
                .background(.ultraThickMaterial.opacity(selectedViewType == "Map" ? 1 : 0), in: .rect(cornerRadius: 8))
                .padding()
                
            }
            .toolbar{
                ToolbarItem{
                    Button(action:{
                        showAddLocation = true
                    }){
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddLocation, content: {
                LocationSearchView(onLocationSaved:{
                    locations.locations.insert($0, at: 0)
                })
            })
            .navigationBarTitle("Saved Locations")
            .onAppear{
                locations.getLocations()
            }
            
        }
    }
    
}

#Preview {
    LocationsView()
}
