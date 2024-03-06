//
//  RoundVarietyCard.swift
//  VeggieVerse
//
//  Created by Ryan Weber on 2/29/24.
//

import SwiftUI

struct RoundVarietyCard: View {
    var fillColor: Color
    var imageURL: String
    var name: String
    var body: some View {
        Capsule()
            .fill(fillColor)
            .frame(width: 180, height: 180)
            .overlay(
                VStack {
                    Image(imageURL)
                        .resizable()
                        .frame(width: 100, height: 75)
                        .border(Color.gradColor1, width: 4)
                        .shadow(radius: 5)
                    Text(name)
                        .font(.title)
                        .padding(.horizontal)
                        .foregroundColor(.black)
                    Text("Variety")
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                        .font(.headline)
                        .shadow(color: .black, radius: 3)
                }
            )
            .shadow(radius: 25)
    }
}

struct RoundVarietyCard_Previews: PreviewProvider {
    static var previews: some View {
        RoundVarietyCard(fillColor: Color.gradColor2, imageURL: "Beefsteak", name: "Beefsteak")
    }
}
