//
//  SowingAndPlantingView.swift
//  VeggieVerse
//
//  Created by Ryan Weber on 3/5/24.
//

import Foundation
import SwiftUI

struct SowingAndPlantingView: View {
    var vegetable: Vegetable
    @Binding var selectedVariety: Variety?
    var userLocation: UserLocation?
    private let adaptiveColumn = [ GridItem(.adaptive(minimum: 150)) ]
    let columns = [ GridItem(.flexible()), GridItem(.flexible()) ]
    var body: some View {
        VStack {
            LazyVGrid(columns: columns) {
                SowingAndPlantingRowView(imageName: "seedSpacing", label: "Seed Spacing", value: vegetable.sowingAndPlanting!.spaceBetweenPlants, imageWidth: 45)
                SowingAndPlantingRowView(imageName: "rowSpacing", label: "Row Spacing", value: vegetable.sowingAndPlanting!.spaceBetweenRows, imageWidth: 45)
                SowingAndPlantingRowView(imageName: "seedDepth", label: "Seed Depth", value: vegetable.sowingAndPlanting!.seedDepth, imageWidth: 45)
                SowingAndPlantingRowView(imageName: "squareFoot", label: "Sq' Spacing", value: String(selectedVariety != nil ? selectedVariety!.squareFootPlantingRecommendations : vegetable.varieties[0].squareFootPlantingRecommendations), imageWidth: 45)
                SowingAndPlantingRowView(imageName: "pH", label: "Soil pH", value: vegetable.sowingAndPlanting!.pHRange, imageWidth: 45)
                SowingAndPlantingRowView(imageName: "temperature", label: "Soil Temp", value: String(vegetable.sowingAndPlanting!.germinationSoilTemp), imageWidth: 45)
            }
            FullWidthTextView(imageName: "seasons", text: "Season", value: vegetable.sowingAndPlanting!.season, imageWidth: 45)
            
            if let plantingDates = userLocation?.getPlantingDates(for: .spring, vegetable: vegetable.name) {
                Text("Spring Planting")
                    .font(Font.custom("AmericanTypewriter", size: 20))
                    .fontWeight(.heavy)
                    .padding(.top)
                LazyVGrid(columns: columns) {
                    SowingAndPlantingRowView(imageName: "sowIndoor", label: "Sow Indoor", value: plantingDates.indoor, imageWidth: 45)
                    SowingAndPlantingRowView(imageName: "transplant", label: "Transplant", value: plantingDates.transplant, imageWidth: 45)
                    SowingAndPlantingRowView(imageName: "sowOutdoor", label: "Sow Outdoor", value: plantingDates.outdoor, imageWidth: 45)
                    SowingAndPlantingRowView(imageName: "lastSowDate", label: "Last Sow Date", value: plantingDates.lastDate, imageWidth: 45)
                }
            }
            if let plantingDates = userLocation?.getPlantingDates(for: .fall, vegetable: vegetable.name) {
                Text("Fall Planting")
                    .font(Font.custom("AmericanTypewriter", size: 20))
                    .fontWeight(.heavy)
                LazyVGrid(columns: columns) {
                    SowingAndPlantingRowView(imageName: "sowIndoor", label: "Sow Indoor", value: plantingDates.indoor, imageWidth: 45)
                    SowingAndPlantingRowView(imageName: "transplant", label: "Transplant", value: plantingDates.transplant, imageWidth: 45)
                    SowingAndPlantingRowView(imageName: "sowOutdoor", label: "Sow Outdoor", value: plantingDates.outdoor, imageWidth: 45)
                    SowingAndPlantingRowView(imageName: "lastSowDate", label: "Last Sow Date", value: plantingDates.lastDate, imageWidth: 45)
                }
            }
            if userLocation != nil {
                if userLocation!.checkIndoorDates(vegetable: vegetable.name) {
                    FullWidthTextView(imageName: "sowIndoor", text: "Indoor Sowing Instructions", value: vegetable.sowingAndPlanting!.sowingIndoorsDescription, imageWidth: 45)
                }
            } else {
                FullWidthTextView(imageName: "sowIndoor", text: "Indoor Sowing Instructions", value: vegetable.sowingAndPlanting!.sowingIndoorsDescription, imageWidth: 45)
            }
            if userLocation != nil {
                if userLocation!.checkOutdoorDates(vegetable: vegetable.name) {
                    FullWidthTextView(imageName: "sowOutdoor", text: "Outdoor Sowing Instructions", value: vegetable.sowingAndPlanting!.sowingIndoorsDescription, imageWidth: 45)
                }
            } else {
                FullWidthTextView(imageName: "sowOutdoor", text: "Outdoor Sowing Instructions", value: vegetable.sowingAndPlanting!.sowingIndoorsDescription, imageWidth: 45)
            }
        }
        .padding(.top, 30)
        .foregroundColor(.black)
        
       
    }
}


struct SowingAndPlantingView_Previews: PreviewProvider {
    static let data = LoadDataModel()
    @State static var selectedVariety: Variety? = nil
    
    static var previews: some View {
        // Simulate creating user location with a mock RealmManager
        let mockRealmManager = RealmManager()
        mockRealmManager.createUserLocationIfNeeded(zipcode: "64068")
//        mockRealmManager.updateUserLocationWithDates(zipcode: "64068")
        let userLocation = mockRealmManager.loadUserLocation()
        return SowingAndPlantingView(vegetable: data.vegetables[0], selectedVariety: $selectedVariety, userLocation: userLocation!)
            .environmentObject(mockRealmManager)
    }
}
