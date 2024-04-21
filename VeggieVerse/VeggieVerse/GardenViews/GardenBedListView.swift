//
//  GardenBedListView.swift
//  VeggieVerse
//
//  Created by Ryan Weber on 3/21/24.
//

import SwiftUI
import RealmSwift

struct GardenBedListView: View {
    @ObservedResults(SquareFootBed.self) var beds
    var body: some View {
        List {
            ForEach(beds, id: \.self) { bed in
                NavigationLink(value: Route.gardenView(bed: bed)) {
                    Text(bed.name)
                }
            }
        }
    }
}

struct GardenBedListView_Previews: PreviewProvider {
    static var previews: some View {
        GardenBedListView()
    }
}
