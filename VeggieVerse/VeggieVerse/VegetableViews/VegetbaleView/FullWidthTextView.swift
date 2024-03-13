//
//  FullWidthTextView.swift
//  VeggieVerse
//
//  Created by Ryan Weber on 3/5/24.
//

import SwiftUI

struct FullWidthTextView: View {
    var imageName: String
    var text: String
    var value: String
    var imageWidth: CGFloat
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: imageWidth, height: imageWidth)

                Text(text)
                    .font(Font.custom("AmericanTypewriter", size: 20))
                    .fontWeight(.heavy)
                Spacer()
            }

            Text(value)
                .font(Font.custom("AmericanTypewriter", size: 15))
                .fontWeight(.regular)
                .padding(.horizontal, 10)
        }
        .padding(.horizontal, 10)
    }
}

struct FullWidthTextView_Previews: PreviewProvider {
    static let data = LoadDataModel()
    static var previews: some View {
        FullWidthTextView(imageName: "wateringNeeds", text: "Water Needs", value: data.vegetables[0].careAndMaintenance!.wateringNeeds, imageWidth: 45)
    }
}
