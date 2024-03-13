//
//  Diseases.swift
//  VeggieVerse
//
//  Created by Ryan Weber on 3/6/24.
//

import SwiftUI

struct DiseaseView: View {
    var vegetable: Vegetable
    var body: some View {
        VStack(spacing: 10) {
            ForEach(vegetable.diseases.sorted(by: { $0.name < $1.name }), id: \.self) { pest in
                VStack {
                    FullWidthTextView(imageName: "disease", text: pest.name, value: pest.descriptionText, imageWidth: 45)
                    Image(pest.name)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
        }
        .padding(.top, 30)
    }
}

struct Diseases_Previews: PreviewProvider {
    static let data = LoadDataModel()
    static var previews: some View {
        DiseaseView(vegetable: data.vegetables[0])
    }
}
