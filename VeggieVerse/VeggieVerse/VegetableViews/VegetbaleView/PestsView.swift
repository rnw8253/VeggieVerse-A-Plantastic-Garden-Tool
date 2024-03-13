//
//  PestsView.swift
//  VeggieVerse
//
//  Created by Ryan Weber on 3/6/24.
//

import SwiftUI

struct PestsView: View {
    var vegetable: Vegetable
    var body: some View {
        VStack(spacing: 10) {
            ForEach(vegetable.pests.sorted(by: { $0.name < $1.name }), id: \.self) { pest in
                FullWidthTextView(imageName: "pest", text: pest.name, value: pest.descriptionText, imageWidth: 45)
                Image(pest.name)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
        .padding(.top, 30)
    }
}

struct PestsView_Previews: PreviewProvider {
    static let data = LoadDataModel()
    static var previews: some View {
        PestsView(vegetable: data.vegetables[1])
    }
}
