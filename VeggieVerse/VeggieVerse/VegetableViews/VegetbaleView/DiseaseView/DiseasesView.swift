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
            ForEach(vegetable.diseases.sorted(by: <), id: \.self) { disease in
                if let matchedDisease = LoadDataModel.shared.diseases.filter({$0.name == disease}).first {
                    DiseaseDisplayView(disease: matchedDisease)
                }
            }
        }
        .padding(.top, 30)
        .foregroundColor(.black)
    }
}

struct Diseases_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            DiseaseView(vegetable: LoadDataModel.shared.vegetables[4])
        }
    }
}
