//
//  DiseaseDisplay.swift
//  VeggieVerse
//
//  Created by Ryan Weber on 3/14/24.
//

import SwiftUI

struct PestDisplayView: View {
    var pest: Pest
    var headerSize: CGFloat = 15
    var textSize: CGFloat = 15
    @State private var showInfo = false
    var body: some View {
        VStack {
            FullWidthTextView(imageName: "pest", text: pest.name, value: "", imageWidth: 45)
            Image(pest.name)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Text("Description: ").fontWeight(.heavy)                   .font(Font.custom("AmericanTypewriter", size: headerSize))+Text(pest.descriptionText)
                .font(Font.custom("AmericanTypewriter", size: textSize))
            Toggle("Show more details", isOn: $showInfo)
                .font(Font.custom("AmericanTypewriter", size: headerSize))
            if showInfo {
                Text("Attractants: ").fontWeight(.heavy)                   .font(Font.custom("AmericanTypewriter", size: headerSize))+Text(pest.attracts)
                    .font(Font.custom("AmericanTypewriter", size: textSize))
                Text("Repellants: ").fontWeight(.heavy)                   .font(Font.custom("AmericanTypewriter", size: headerSize))+Text(pest.repels)
                    .font(Font.custom("AmericanTypewriter", size: textSize))
                Text("Prevention: ").fontWeight(.heavy)                   .font(Font.custom("AmericanTypewriter", size: headerSize))+Text(pest.prevention)
                    .font(Font.custom("AmericanTypewriter", size: textSize))
                Text("Treatment ").fontWeight(.heavy)                   .font(Font.custom("AmericanTypewriter", size: headerSize))+Text(pest.removal)
                    .font(Font.custom("AmericanTypewriter", size: textSize))
            }
            
        }
        .padding()
    }
}

struct PestDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        PestDisplayView(pest: LoadDataModel.shared.pests[3])
    }
}
