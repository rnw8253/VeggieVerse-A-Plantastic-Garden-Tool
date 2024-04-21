//
//  GardenBedSquareTileView.swift
//  VeggieVerse
//
//  Created by Ryan Weber on 3/27/24.
//

import Foundation
import SwiftUI
import RealmSwift

struct GardenBedTileContainerView: View {
    @Binding var lockable: Bool
    @ObservedRealmObject var square: Square
    var gridSize: CGFloat
    @State private var isTarget: Bool = false
    var index: Int
    @ObservedRealmObject var bed: SquareFootBed
    var body: some View {
        
        if lockable {
            Button {
                RealmManager.shared.toggleSquareLockState(id: square.id)
            } label: {
                GardenBedTileDisplayView(square: square, gridSize: gridSize, isTargeted: isTarget, bed: bed)
                
            }
        } else {
            if !square.locked {
                GardenBedTileDisplayView(square: square, gridSize: gridSize, isTargeted: isTarget, bed: bed)
                    .dropDestination(for: String.self) { droppedSquares, location in
                        if let droppedSquare = droppedSquares.first {
                            RealmManager.shared.swapPlants(bedID: bed.id, index1: Int(index), index2: Int(droppedSquare)!)
                            return false
                        } else {
                            return true
                        }
                    } isTargeted: { isTargeted in
                        isTarget = isTargeted
                    }
                    .draggable(String(index))
            } else {
                GardenBedTileDisplayView(square: square, gridSize: gridSize, isTargeted: isTarget, bed: bed)
            }
        }
    }
}


struct GardenBedSquareTileContainerView_Previews: PreviewProvider {
    static var previews: some View {
        GardenBedLayoutView(bed: RealmManager.shared.localRealm?.objects(SquareFootBed.self).first ?? GenerateBed())
    }
}



