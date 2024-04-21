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
            ForEach(vegetable.pests.sorted(by: <), id: \.self) { pest in
                if let matchedPest = LoadDataModel.shared.pests.filter({$0.name == pest}).first {
                    PestDisplayView(pest: matchedPest)
                }
            }
        }
        .padding(.top, 30)
        .foregroundColor(.black)
    }
}

struct PestsView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            PestsView(vegetable: LoadDataModel.shared.vegetables[4])
        }
    }
}
