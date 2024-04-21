//
//  CompanionPlants.swift
//  VeggieVerse
//
//  Created by Ryan Weber on 3/7/24.
//

import SwiftUI

struct CompanionPlantsView: View {
    var vegetable: Vegetable
    var body: some View {
        ScrollView {
            VStack {
                Text("Good Companions")
                    .font(Font.custom("AmericanTypewriter", size: 25))
                    .fontWeight(.heavy)
                ForEach(vegetable.companionPlants!.goodCompanionPlants, id: \.self) { cp in
//                    if (UIImage.init(named: "\(cp.name)_thumbnail") != nil) {
//                        FullWidthTextView(imageName: "\(cp.name)_thumbnail", text: cp.name, value: cp.descriptionText, imageWidth: 45)
//                    } else {
//                        FullWidthTextView(imageName: "goodCompanion", text: cp.name, value: cp.descriptionText, imageWidth: 45)
//                    }
                    FullWidthTextView(imageName: "goodCompanion", text: cp.name, value: cp.descriptionText, imageWidth: 45)
                }
                Text("Bad Companions")
                    .font(Font.custom("AmericanTypewriter", size: 25))
                    .fontWeight(.heavy)
                    .padding(.top, 30)
                ForEach(vegetable.companionPlants!.badCompanionPlants, id: \.self) { cp in
//                    if (UIImage.init(named: "\(cp.name)_thumbnail") != nil) {
//                        FullWidthTextView(imageName: "\(cp.name)_thumbnail", text: cp.name, value: cp.descriptionText, imageWidth: 75)
//                    } else {
//                        FullWidthTextView(imageName: "badCompanion", text: cp.name, value: cp.descriptionText, imageWidth: 45)
//                    }
                    FullWidthTextView(imageName: "badCompanion", text: cp.name, value: cp.descriptionText, imageWidth: 45)
                }
            }
            .padding(.top, 30)
            .foregroundColor(.black)
        }
    }
}

struct CompanionPlantsView_Previews: PreviewProvider {
    static var previews: some View {
        CompanionPlantsView(vegetable: LoadDataModel.shared.vegetables[0])
    }
}
