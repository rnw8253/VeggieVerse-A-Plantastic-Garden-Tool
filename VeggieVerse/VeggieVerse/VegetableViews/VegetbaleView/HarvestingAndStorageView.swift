//
//  HarvestingAndStorageView.swift
//  VeggieVerse
//
//  Created by Ryan Weber on 3/5/24.
//

import SwiftUI

struct HarvestingAndStorageView: View {
    var vegetable: Vegetable
    var body: some View {
        VStack(spacing: 10) {
            FullWidthTextView(imageName: "harvest", text: "Harvest Overview", value: vegetable.harvestingAndStorage!.harvestDescription, imageWidth: 45)
            FullWidthTextView(imageName: "time", text: "Time To Maturity", value: vegetable.harvestingAndStorage!.timeToMaturity, imageWidth: 45)
            FullWidthTextView(imageName: "storage", text: "Storage", value: vegetable.harvestingAndStorage!.storageRecommendations, imageWidth: 45)
        }
        .padding(.top, 30)
    }
}

struct HarvestingAndStorageView_Previews: PreviewProvider {
    static let data = LoadDataModel()
    static var previews: some View {
        HarvestingAndStorageView(vegetable: data.vegetables[0])
    }
}
