//
//  SowingAndPlantingRowView.swift
//  VeggieVerse
//
//  Created by Ryan Weber on 3/5/24.
//

import Foundation
import SwiftUI


struct SowingAndPlantingRowView: View {
    var imageName: String
    var label: String
    var value: String
    var imageWidth: CGFloat
    var body: some View {
        HStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: imageWidth, height: imageWidth)
            VStack(alignment: .center) {
                Text(label)
                    .font(Font.custom("AmericanTypewriter", size: 14))
                    .fontWeight(.heavy)
                Text(value)
                    .font(Font.custom("AmericanTypewriter", size: 20))
            }
            .frame(width: 100)
            .padding(.vertical, 20)
            .padding(.horizontal, 10)
        }
    }
}

struct SowingAndPlantingRowView_Previews: PreviewProvider {
    static var previews: some View {
        SowingAndPlantingRowView(imageName: "sowIndoor", label: "Sow Indoor", value: "Jan 2 - Mar 13", imageWidth: 40)
    }
}
