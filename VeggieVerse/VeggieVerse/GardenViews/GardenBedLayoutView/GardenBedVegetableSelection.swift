//
//  VegetableListView.swift
//  VeggieVerse
//
//  Created by Ryan Weber on 2/25/24.
//

import Foundation
import SwiftUI
import RealmSwift

struct GardenBedVegetableSelection: View {
    private let adaptiveColumns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 3)
    @State private var filterString: String = ""
    var squareID: ObjectId
    @ObservedRealmObject var bed: SquareFootBed
    var filteredVegetables: [String : Int] {
        let plants = bed.unassignedPlantCounts()
        if filterString == "" {
            print(plants)
            return plants
        } else {
            return Dictionary(uniqueKeysWithValues: plants.filter { $0.key.lowercased().contains(filterString.lowercased()) })
        }
    }
    
    var body: some View {
        ZStack {
            Color.themeBackground
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                LazyVGrid(columns: adaptiveColumns, spacing: 20) {
                    ForEach(filteredVegetables.keys.sorted(), id: \.self) { key in
                        if let vegetable = RealmManager.shared.localRealm!.objects(Vegetable.self).filter("name == %@", key).first {
                            Button {
                                RealmManager.shared.addNewPlantToSquare(id: squareID, plant: vegetable)
                                AppState.shared.popXViews(1)
                            } label: {
                                VStack {
                                    Image(vegetable.thumbnailImageUrl)
                                        .resizable()
                                        .aspectRatio(1, contentMode: .fit)
                                        .cornerRadius(10)
                                        .overlay(RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.themeAccent, lineWidth: 4))
                                        .shadow(radius: 15)
                                        .frame(minWidth: 100, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity)
                                    Text("\(vegetable.name) (\(filteredVegetables[key] ?? 1))")
                                        .font(.headline)
                                        .lineLimit(2, reservesSpace: true)
                                        .foregroundColor(.black)
                                }
                            }
                        }
                    }
                    VStack {
                        NavigationLink(value: Route.vegetableListView) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.themeAccent, lineWidth: 4)
                                    .background(.white)
                                    .foregroundColor(.clear)
                                    .overlay(
                                        Image(systemName: "plus.circle")
                                            .resizable()
                                            .padding(20)
                                    )
                            }
                        }
                        .frame(minWidth: 100, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity)
                        Text("Add Plant To Garden")
                            .font(.headline)
                            .lineLimit(2, reservesSpace: true)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                    }
                }
                .searchable(text: $filterString, placement: .navigationBarDrawer(displayMode: .always) )
                .padding(.horizontal)
            }
            .navigationBarTitle("Garden Vegetables", displayMode: .inline)
            .padding(.bottom)
        }
        .background(Color.themeBackground)
    }
}

struct GardenBedVegetableSelection_Previews: PreviewProvider {
    static let bed = GenerateBed()
    static var previews: some View {
        GardenBedVegetableSelection(squareID: bed.squares[0].id, bed: bed)
    }
}


