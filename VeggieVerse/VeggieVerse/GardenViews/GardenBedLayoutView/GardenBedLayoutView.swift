//
//  GardenBedView.swift
//  VeggieVerse
//
//  Created by Ryan Weber on 3/21/24.
//

import SwiftUI
import RealmSwift

struct GardenBedLayoutView: View {
    @ObservedRealmObject var bed: SquareFootBed
    @ObservedResults(Square.self) var squares
    @State var isCalculating: Bool = false
    @State var lockable: Bool = false
    var gridSize: CGFloat {
        return 75
    }
    var columns: [GridItem] {
        var temp: [GridItem] = []
        for _ in 0...min(bed.width, bed.length) {
            temp.append(GridItem(.fixed(gridSize), spacing: 0))
        }
        temp.remove(at: 0)
        return temp
    }
    var body: some View {
        ZStack {
            VStack {
                LazyVGrid(columns: columns, spacing: 0) {
                    ForEach(bed.squares, id: \.self) { square in
                        GardenBedTileContainerView(lockable: $lockable, square: square, gridSize: gridSize, index: square.index, bed: bed)
                    }
                }
                HStack {
                    Button {
                        bed.calculateOptimalLayout(isCalculating: $isCalculating ,initial_temperature: 120, cooling_rate: 0.90, iterations: 5000)
                    } label: {
                        RoundedRectangle(cornerRadius: 10)
                            .overlay(
                                Text("Optimize")
                                    .foregroundColor(.white)
                            )
                            .frame(maxHeight: 50)
                    }
                    Spacer()
                    Button {
                        RealmManager.shared.randomlyAssignPlants(bedID: bed.id)
                    } label: {
                        RoundedRectangle(cornerRadius: 10)
                            .overlay(
                                Text("Randomize")
                                    .foregroundColor(.white)
                            )
                            .frame(maxHeight: 50)
                    }
                    Button {
//                        if bed.squares[0].plant == nil {
//                            RealmManager.shared.updateSquarePlant(id: bed.squares[0].id, plant: LoadDataModel.shared.vegetables.randomElement())
//                        } else {
//                            RealmManager.shared.updateSquarePlant(id: bed.squares[0].id, plant: nil)
//                        }
                        lockable.toggle()
                    } label: {
                        RoundedRectangle(cornerRadius: 10)
                            .overlay(
                                Text("Edit Lock")
                                    .foregroundColor(.white)
                            )
                            .frame(maxHeight: 50)
                    }
                    
                }
                .padding(.horizontal, 50)
            }
            if isCalculating {
                Color.black.opacity(0.5).edgesIgnoringSafeArea(.all)
                
                ProgressView("Calculating...")
                    .tint(.white)
                    .scaleEffect(3)
                    .fontWeight(.bold)
                    .font(.subheadline)
                    .opacity(100)
                    .foregroundColor(.white)
            }
        }
    }
}

struct GardenBedLayoutView_Previews: PreviewProvider {
    static var previews: some View {
        GardenBedLayoutView(bed: RealmManager.shared.localRealm?.objects(SquareFootBed.self).first ?? GenerateBed())
    }
}



