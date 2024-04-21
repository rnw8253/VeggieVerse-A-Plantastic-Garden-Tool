//
//  CareAndMaintenanceView.swift
//  VeggieVerse
//
//  Created by Ryan Weber on 3/5/24.
//
//
import SwiftUI

struct CareAndMaintenanceView: View {
    var vegetable: Vegetable
    let columns = [ GridItem(.flexible()), GridItem(.flexible()) ]
    var body: some View {
        VStack(spacing: 10) {
            FullWidthTextView(imageName: "overview", text: "Maintenance Overview", value: vegetable.careAndMaintenance!.growingDescription, imageWidth: 45)
            LazyVGrid(columns: columns) {
                HalfWidthTextView(imageName: "sun", label: "Optimal Sun", value: vegetable.careAndMaintenance!.optimalSun, imageWidth: 45)
                HalfWidthTextView(imageName: "temperature", label: "Soil Temp", value: vegetable.careAndMaintenance!.growingSoilTemp, imageWidth: 45)
            }
            FullWidthTextView(imageName: "wateringNeeds", text: "Water Needs", value: vegetable.careAndMaintenance!.wateringNeeds, imageWidth: 45)
            FullWidthTextView(imageName: "fertilizer", text: "Soil Fertility", value: vegetable.careAndMaintenance!.soilFertility, imageWidth: 45)
            FullWidthTextView(imageName: "pruning", text: "Pruning Requirements", value: vegetable.careAndMaintenance!.pruningRequirements, imageWidth: 45)
            FullWidthTextView(imageName: "trellis", text: "Support", value: vegetable.careAndMaintenance!.supportRequirements, imageWidth: 45)
        }
        .padding(.top, 30)
        .foregroundColor(.black)
    }
}

struct CareAndMaintenanceView_Previews: PreviewProvider {
    static var previews: some View {
        CareAndMaintenanceView(vegetable: LoadDataModel.shared.vegetables[2])
    }
}




