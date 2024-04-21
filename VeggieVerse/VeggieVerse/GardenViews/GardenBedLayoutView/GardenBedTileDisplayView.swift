//
//  GardenBedTileDisplayView.swift
//  VeggieVerse
//
//  Created by Ryan Weber on 4/9/24.
//

import Foundation
import SwiftUI
import RealmSwift

struct GardenBedTileDisplayView: View {
    @State var dragAmount = CGSize.zero
    var square: Square
    var gridSize: CGFloat
    var isTargeted: Bool
    @ObservedRealmObject var bed: SquareFootBed
    var body: some View {
        ZStack {
            if square.plant != nil {
                VStack(spacing: 0) {
                    Image(square.plant!.plant.thumbnailImageUrl)
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                    Text(square.plant!.plant.name)
                        .padding(.horizontal, 5)
                        .scaledToFit()
                        .minimumScaleFactor(0.2)
                        .foregroundColor(.black)
                }
                .padding(.bottom, 2)
                .aspectRatio(1, contentMode: .fit)
                .frame(minWidth: gridSize, minHeight: gridSize)
            } else {
                NavigationLink(value: Route.gardenBedVegetableList(squareID: square.id, bed: bed)) {
                    Image(systemName: "plus.circle")
                        .foregroundColor(.secondary)
                }
            }
            if square.locked {
                VStack {
                    HStack {
                        Spacer()
                        Image(systemName: "lock.fill")
                            .foregroundColor(.black)
                            .animation(.easeIn, value: 0.1)
                    }
                    Spacer()
                }
                .padding(2)
            }
            
            
            Rectangle()
                .stroke(.black, lineWidth: 2)
                .foregroundColor(.clear)
                .frame(minWidth: gridSize, minHeight: gridSize)
                .shadow(radius: isTargeted == true ? 2 : 0)
                .shadow(radius: isTargeted == true ? 2 : 0)
                .shadow(radius: isTargeted == true ? 2 : 0)
                .shadow(radius: isTargeted == true ? 2 : 0)
            
        }



        .background(.white)
    }
}

struct GardenBedTileDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        GardenBedLayoutView(bed: RealmManager.shared.localRealm?.objects(SquareFootBed.self).first ?? GenerateBed())
    }
}
