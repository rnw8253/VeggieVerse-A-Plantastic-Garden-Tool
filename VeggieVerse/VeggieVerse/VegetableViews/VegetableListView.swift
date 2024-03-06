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
    var body: some View {
        ZStack {
            Color.themeBackground
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                LazyVGrid(columns: adaptiveColumns, spacing: 20) {
                    ForEach(data.vegetables) { vegetable in
                        NavigationLink(value: Route.vegetableView(vegetable: vegetable)) {
                            VStack {
                                Image(vegetable.thumbnailImageUrl)
                                    .resizable()
                                    .aspectRatio(1, contentMode: .fit)
                                    .cornerRadius(10)
                                    .overlay(RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.themeSecondary, lineWidth: 4))
                                    .shadow(radius: 10)
                                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100)
                                Text(vegetable.name)
                                    .font(.headline)
                                    .foregroundColor(Color.themeAccent)
                            }
                            
                        }
                    }
                }
                .padding(.horizontal)
            }
            .navigationBarTitle("Vegetables", displayMode: .inline)
            .padding(.bottom)
        }
    }
}

struct VegetableListView_Previews: PreviewProvider {
    static var previews: some View {
        VegetableListView().environmentObject(LoadDataModel())
    }
}


