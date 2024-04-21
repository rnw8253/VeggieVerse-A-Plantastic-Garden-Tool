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
    var userLocation: UserLocation? = RealmManager.shared.loadUserLocation()
    private let adaptiveColumn = [ GridItem(.adaptive(minimum: 150)) ]
    let columns = [ GridItem(.flexible()), GridItem(.flexible()) ]
    var body: some View {
        VStack {
            FullWidthTextView(imageName: "seasons", text: "Season", value: vegetable.sowingAndPlanting!.season, imageWidth: 45)
            LazyVGrid(columns: columns) {
                
                HalfWidthTextView(imageName: "seedSpacing", label: "Seed Spacing", value: vegetable.sowingAndPlanting!.spaceBetweenPlants, imageWidth: 45)
                HalfWidthTextView(imageName: "rowSpacing", label: "Row Spacing", value: vegetable.sowingAndPlanting!.spaceBetweenRows, imageWidth: 45)
                HalfWidthTextView(imageName: "seedDepth", label: "Seed Depth", value: vegetable.sowingAndPlanting!.seedDepth, imageWidth: 45)
                if vegetable.sowingAndPlanting!.squareFootPlantingRecommendationsMin == vegetable.sowingAndPlanting!.squareFootPlantingRecommendationsMax {
                    if vegetable.sowingAndPlanting!.squareFootPlantingRecommendationsMin == 0 {
                        HalfWidthTextView(imageName: "squareFoot", label: "Sq' Spacing", value: "-", imageWidth: 45)
                    } else {
                        HalfWidthTextView(imageName: "squareFoot", label: "Sq' Spacing", value: String(vegetable.sowingAndPlanting!.squareFootPlantingRecommendationsMin), imageWidth: 45)
                    }
                } else {
                    HalfWidthTextView(imageName: "squareFoot", label: "Sq' Spacing", value: "\(vegetable.sowingAndPlanting!.squareFootPlantingRecommendationsMin) - \(vegetable.sowingAndPlanting!.squareFootPlantingRecommendationsMax)", imageWidth: 45)
                }
                HalfWidthTextView(imageName: "pH", label: "Soil pH", value: vegetable.sowingAndPlanting!.pHRange, imageWidth: 45)
                HalfWidthTextView(imageName: "temperature", label: "Soil Temp", value: String(vegetable.sowingAndPlanting!.germinationSoilTemp), imageWidth: 45)
            }
            let (springIndoor, springTransplant, springOutdoor, lastSowDate, fallTransplant, fallOutdoor, daysToMaturity, frostTolerance) = CalculateSpringSowDateString(vegetable: vegetable)
            Text("Spring Planting")
                .font(Font.custom("AmericanTypewriter", size: 20))
                .fontWeight(.heavy)
                .padding(.top)
            LazyVGrid(columns: columns) {
                HalfWidthTextView(imageName: "sowIndoor", label: "Sow Indoors", value: springIndoor, imageWidth: 45)
                HalfWidthTextView(imageName: "transplant", label: "Transplant", value: springTransplant, imageWidth: 45)
                HalfWidthTextView(imageName: "sowOutdoor", label: "Sow Outdoors", value: springOutdoor, imageWidth: 45)
                HalfWidthTextView(imageName: "lastSowDate", label: "Last Sow Date", value: lastSowDate, imageWidth: 45)
            }
            Text("Fall Planting")
                .font(Font.custom("AmericanTypewriter", size: 20))
                .fontWeight(.heavy)
                .padding(.top)
            LazyVGrid(columns: columns) {
                HalfWidthTextView(imageName: "sowOutdoor", label: "Sow Outdoor", value: fallOutdoor, imageWidth: 45)
                HalfWidthTextView(imageName: "transplant", label: "Transplant", value: fallTransplant, imageWidth: 45)
                HalfWidthTextView(imageName: "time", label: "Days To Maturity", value: daysToMaturity, imageWidth: 45)
                HalfWidthTextView(imageName: "frost", label: "Frost Tolerance", value: frostTolerance, imageWidth: 45)
            }
            if userLocation != nil {
                if userLocation!.checkIndoorDates(vegetable: vegetable.name) {
                    FullWidthTextView(imageName: "sowIndoor", text: "Indoor Sowing Instructions", value: vegetable.sowingAndPlanting!.sowingIndoorsDescription, imageWidth: 45)
                } else {
                    FullWidthTextView(imageName: "sowIndoor", text: "Indoor Sowing Instructions", value: vegetable.sowingAndPlanting!.sowingIndoorsDescription, imageWidth: 45)
                }
            } else {
                FullWidthTextView(imageName: "sowIndoor", text: "Indoor Sowing Instructions", value: vegetable.sowingAndPlanting!.sowingIndoorsDescription, imageWidth: 45)
            }
            if userLocation != nil {
                if userLocation!.checkOutdoorDates(vegetable: vegetable.name) {
                    FullWidthTextView(imageName: "sowOutdoor", text: "Outdoor Sowing Instructions", value: vegetable.sowingAndPlanting!.sowingOutdoorsDescription, imageWidth: 45)
                } else {
                    FullWidthTextView(imageName: "sowOutdoor", text: "Outdoor Sowing Instructions", value: vegetable.sowingAndPlanting!.sowingOutdoorsDescription, imageWidth: 45)
                }
            } else {
                FullWidthTextView(imageName: "sowOutdoor", text: "Outdoor Sowing Instructions", value: vegetable.sowingAndPlanting!.sowingOutdoorsDescription, imageWidth: 45)
            }
        }
        .padding(.top, 30)
        .foregroundColor(.black)
        
        
    }
}


struct SowingAndPlantingView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView{
            SowingAndPlantingView(vegetable: LoadDataModel.shared.vegetables[79])
        }
    }
}
