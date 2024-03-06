//
//  VegetableSectionHeaderView.swift
//  VeggieVerse
//
//  Created by Ryan Weber on 3/5/24.
//

import Foundation
import SwiftUI



struct VegetableSectionHeaderView: View {
    var text: String
    var curveVal: CGFloat
    var fillColor: Color
    var body: some View {
        CurveSidedRectangle(curveHeightTop: curveVal, curveHeightBottom: curveVal)
            .fill(fillColor)
            .frame(height: 70)
            .padding(.vertical, 10)
            .overlay(
                Text(text)
                    .font(Font.custom("AmericanTypewriter", size: 25))
                    .foregroundColor(.black)
                    .padding(.top, 40)
            )
    }
}

struct VegetableSectionHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        VegetableSectionHeaderView(text: "Sowing and Planting", curveVal: 50, fillColor: Color.gradColor2)
    }
}
