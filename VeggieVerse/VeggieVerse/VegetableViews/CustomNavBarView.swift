//
//  CustomNavBar.swift
//  VeggieVerse
//
//  Created by Ryan Weber on 2/28/24.
//

import SwiftUI

struct CustomNavBarView: View {
    @EnvironmentObject var appState: AppState
    var title: String
    var titleColor: Color
    var backgroundColor: Color = .clear
    var showBackButton = false
    var body: some View {
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
        .foregroundColor(titleColor)
        .font(.headline)
        .background(backgroundColor)
//        .frame(height: )

    }
}

struct CustomNavBarView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CustomNavBarView(title: "Tomato", titleColor: Color.white, backgroundColor: .red)
            Spacer()
        }
    }
}

extension CustomNavBarView {
    private var backButton: some View {
        Button {
            appState.popXViews(1)
        } label: {
            Image(systemName: "chevron.left")
        }
    }
    
    private var titleSection: some View {
        Text(title)
            .font(.largeTitle)
            .fontWeight(.black)
    }
}
