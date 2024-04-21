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
    var showBackButton = false
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
            VegetableNavBarView(title: "German Chamomile", titleColor: Color.white, shadowColor: .black, openColor: .green, height: 130, curveVal: 50, backgroundImage: "Tomatoes_background")

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
                .shadow(radius: 15)
        }
        .frame(width: 75, height: 75)
    }
    
    private var titleSection: some View {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.black)
                .shadow(radius: 15)
                .multilineTextAlignment(.center)
                .scaledToFit()
                .minimumScaleFactor(0.5)
                .lineLimit(2)
    }
}
