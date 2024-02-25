//
//  VegetableListView.swift
//  VeggieVerse
//
//  Created by Ryan Weber on 2/25/24.
//

import Foundation
import SwiftUI

struct VegetableListView: View {
    @EnvironmentObject var data: LoadDataModel
    var body: some View {
        VStack {
            List {
                ForEach(data.vegetables.sorted(byKeyPath: "name"), id: \.vegetableId) { vegetable in
                    HStack {
                        AsyncImage(url: URL(string: vegetable.thumbnailImage)) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                            .frame(maxWidth: 50, maxHeight: 75)
                        Text(vegetable.name)
                    }
                }
            }
        }
        .navigationTitle("Vegetables")
    }
}

struct VegetableListView_Previews: PreviewProvider {
    static var previews: some View {
        VegetableListView().environmentObject(LoadDataModel())
    }
}
