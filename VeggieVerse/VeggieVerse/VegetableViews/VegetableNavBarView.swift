//
//  CustomNavBar.swift
//  VeggieVerse
//
//  Created by Ryan Weber on 2/28/24.
//

import SwiftUI

struct VegetableNavBarView: View {
    @EnvironmentObject var appState: AppState
    var title: String
    var titleColor: Color
    var shadowColor: Color
    var openColor: Color
    var height: CGFloat
    var curveVal: CGFloat
    var backgroundImage: String
    var showBackButton = true
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Image(backgroundImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: height)
                    .clipShape(CurveSidedRectangle(curveHeightTop: 0, curveHeightBottom: -curveVal))
                
                HStack {
                    if showBackButton {
                        backButton
                    }
                    Spacer()
                    titleSection
                    Spacer()
                    if showBackButton {
                        backButton
                            .opacity(0)
                    }
                }
                .padding(.horizontal)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(titleColor)
                .shadow(color: shadowColor, radius: 5)
            }
//            CurveSidedRectangle(curveHeightTop: -curveVal, curveHeightBottom: curveVal)
//                .fill(openColor)
//                .frame(height: 10)
            
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct VegetableNavBarView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            VegetableNavBarView(title: "Tomatoes", titleColor: Color.white, shadowColor: .black, openColor: .green, height: 100, curveVal: 50, backgroundImage: "Tomatoes_background")
            Spacer()
        }
    }
}

extension VegetableNavBarView {
    private var backButton: some View {
        Button {
            appState.popXViews(1)
        } label: {
            Image(systemName: "chevron.left")
        }
        .frame(width: 50, height: 50)
    }
    
    private var titleSection: some View {
        Text(title)
            .font(.largeTitle)
            .fontWeight(.black)
    }
}
