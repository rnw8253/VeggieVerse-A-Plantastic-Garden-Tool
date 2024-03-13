//
//  VegetableSectionHeaderView.swift
//  VeggieVerse
//
//  Created by Ryan Weber on 3/5/24.
//

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
                    Button {
                        switch currentHeader {
                        case .sowingAndPlanting:
                            currentHeader = .companions
                        case .careAndMaintenance:
                            currentHeader = .sowingAndPlanting
                        case .harvestAndStorage:
                            currentHeader = .careAndMaintenance
                        case .pests:
                            currentHeader = .harvestAndStorage
                        case .disease:
                            currentHeader = .pests
                        case .companions:
                            currentHeader = .disease
                        }
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                            .imageScale(.large)
                            .fontWeight(.heavy)
                    }
                    .padding(.top, 30)
                    Spacer()
                    Text(currentHeader.rawValue)
                        .font(Font.custom("AmericanTypewriter", size: 25))
                        .foregroundColor(.black)
                        .padding(.top, 40)
                    Spacer()
                    Button {
                        switch currentHeader {
                        case .sowingAndPlanting:
                            currentHeader = .careAndMaintenance
                        case .careAndMaintenance:
                            currentHeader = .harvestAndStorage
                        case .harvestAndStorage:
                            currentHeader = .pests
                        case .pests:
                            currentHeader = .disease
                        case .disease:
                            currentHeader = .companions
                        case .companions:
                            currentHeader = .sowingAndPlanting
                        }
                    } label: {
                        Image(systemName: "chevron.right")
                            .foregroundColor(.black)
                            .imageScale(.large)
                            .fontWeight(.heavy)
                        
                    }
                    .padding(.top, 30)
                }

                .padding(.horizontal,30)
            )
    }
}

//struct VegetableSectionHeaderView: View {
//    var text: String
//    var curveVal: CGFloat
//    var fillColor: Color
//    var body: some View {
//        CurveSidedRectangle(curveHeightTop: curveVal, curveHeightBottom: curveVal)
//            .fill(fillColor)
//            .frame(height: 70)
//            .padding(.vertical, 10)
//            .overlay(
//                Text(text)
//                    .font(Font.custom("AmericanTypewriter", size: 25))
//                    .foregroundColor(.black)
//                    .padding(.top, 40)
//            )
//    }
//}

struct VegetableSectionHeaderView_Previews: PreviewProvider {
    @State static var currentHeader: CurrentVegetableHeaderView = .sowingAndPlanting
    static var previews: some View {
        VegetableSectionHeaderView(currentHeader: $currentHeader, curveVal: 50, fillColor: Color.gradColor2)
    }
}
