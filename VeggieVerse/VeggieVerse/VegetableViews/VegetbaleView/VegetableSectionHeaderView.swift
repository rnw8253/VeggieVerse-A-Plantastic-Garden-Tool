
//  VegetableSectionHeaderView.swift
//  VeggieVerse
//
//  Created by Ryan Weber on 3/5/24.


import Foundation
import SwiftUI

struct VegetableSectionHeaderView: View {
    @Binding var currentHeader: CurrentVegetableHeaderView
    var curveVal: CGFloat
    var fillColor: Color
    var chevronSize: CGFloat = 30
    var body: some View {
        CurveSidedRectangle(curveHeightTop: curveVal, curveHeightBottom: curveVal)
            .fill(fillColor)
            .frame(height: 70)
            .padding(.vertical, 10)
            .overlay(
                HStack {
                    Spacer()
                    Text(currentHeader.rawValue)
                        .font(Font.custom("AmericanTypewriter", size: 25))
                        .foregroundColor(.black)
                        .padding(.top, 40)
                    Spacer()
                }
                    .padding(.horizontal,30)
            )
    }
}

struct VegetableSectionHeaderView_Previews: PreviewProvider {
    @State static var currentHeader: CurrentVegetableHeaderView = .sowingAndPlanting
    static var previews: some View {
        VegetableSectionHeaderView(currentHeader: $currentHeader, curveVal: 50, fillColor: Color.gradColor2)
    }
}
