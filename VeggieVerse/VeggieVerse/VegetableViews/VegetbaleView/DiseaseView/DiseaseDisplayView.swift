//
//  DiseaseDisplay.swift
//  VeggieVerse
//
//  Created by Ryan Weber on 3/14/24.
//

import SwiftUI

struct DiseaseDisplayView: View {
    var disease: Disease
    var headerSize: CGFloat = 15
    var textSize: CGFloat = 15
    @State private var showInfo = false
    var body: some View {
        VStack {
            FullWidthTextView(imageName: "disease", text: disease.name, value: "", imageWidth: 45)
            Image(disease.name)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text("Description: ").fontWeight(.heavy)                   .font(Font.custom("AmericanTypewriter", size: headerSize))+Text(disease.descriptionText)
                .font(Font.custom("AmericanTypewriter", size: textSize))
            Toggle("Show more details", isOn: $showInfo)
                .font(Font.custom("AmericanTypewriter", size: headerSize))
            if showInfo {
                Text("Causes: ").fontWeight(.heavy)                   .font(Font.custom("AmericanTypewriter", size: headerSize))+Text(disease.causes)
                    .font(Font.custom("AmericanTypewriter", size: textSize))
                Text("Prevention: ").fontWeight(.heavy)                   .font(Font.custom("AmericanTypewriter", size: headerSize))+Text(disease.prevention)
                    .font(Font.custom("AmericanTypewriter", size: textSize))
                Text("Treatment ").fontWeight(.heavy)                   .font(Font.custom("AmericanTypewriter", size: headerSize))+Text(disease.removal)
                    .font(Font.custom("AmericanTypewriter", size: textSize))
            }
            
        }
        .padding()
    }
}

struct DiseaseDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            DiseaseDisplayView(disease: LoadDataModel.shared.diseases[15])
        }
    }
}
