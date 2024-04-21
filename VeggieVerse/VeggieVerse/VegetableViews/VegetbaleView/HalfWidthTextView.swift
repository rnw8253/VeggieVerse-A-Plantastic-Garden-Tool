//
//  HalfWidthTextView.swift
//  VeggieVerse
//
//  Created by Ryan Weber on 3/5/24.
//

import Foundation
import SwiftUI


struct HalfWidthTextView: View {
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
                    .multilineTextAlignment(.center)
                    .font(Font.custom("AmericanTypewriter", size: 14))
                    .fontWeight(.heavy)
                Text(value)
                    .multilineTextAlignment(.center)
                    .font(Font.custom("AmericanTypewriter", size: 20))
            }
            .frame(width: 100)
            .padding(.vertical, 20)
            .padding(.horizontal, 10)
        }
    }
}

struct HalfWidthTextView_Previews: PreviewProvider {
    static var previews: some View {
        HalfWidthTextView(imageName: "sowIndoor", label: "Sow Indoor", value: "Jan 2 - Mar 13", imageWidth: 40)
    }
}
