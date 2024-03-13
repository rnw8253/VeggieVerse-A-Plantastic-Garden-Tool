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
    private let adaptiveColumns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 3)
    @State private var filterString: String = ""
    var filteredVegetables: [Vegetable] {
        if filterString == "" {
            return data.vegetables.sorted(by: { $0.name < $1.name })
        } else {
            
            return data.vegetables.filter({$0.name.lowercased().contains(filterString.lowercased())}).sorted(by: { $0.name < $1.name })
        }
    }
    var body: some View {
        ZStack {
            Color.themeBackground
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                LazyVGrid(columns: adaptiveColumns, spacing: 20) {
                    ForEach(filteredVegetables) { vegetable in
                        NavigationLink(value: Route.vegetableView(vegetable: vegetable)) {
                            VStack {
                                Image(vegetable.thumbnailImageUrl)
                                    .resizable()
                                    .aspectRatio(1, contentMode: .fit)
                                    .cornerRadius(10)
                                    .overlay(RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.themeAccent, lineWidth: 4))
                                    .shadow(radius: 15)
                                    .frame(minWidth: 100, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity)
                                Text(vegetable.name)
                                    .font(.headline)
                                    .foregroundColor(.black)
                            }
                            
                        }
                    }
                }
                .searchable(text: $filterString, placement: .navigationBarDrawer(displayMode: .always) )
                .padding(.horizontal)
            }
            .navigationBarTitle("Vegetables", displayMode: .inline)
            .padding(.bottom)
        }
        .background(Color.themeBackground)
    }
}

struct VegetableListView_Previews: PreviewProvider {
    static var previews: some View {
        VegetableListView().environmentObject(LoadDataModel())
    }
}


