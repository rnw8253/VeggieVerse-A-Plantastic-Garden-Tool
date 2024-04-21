//
//  Route.swift
//  VeggieVerse
//
//  Created by Ryan Weber on 2/25/24.
//

import Foundation
import SwiftUI
import RealmSwift

enum Route {
    case vegetableListView
    case vegetableView(vegetable: Vegetable)
    case gardenView(bed: SquareFootBed)
    case gardenListView
    case gardenBedVegetableList(squareID: ObjectId, bed: SquareFootBed)
}


extension Route: View {
    var body: some View {
        switch self {
        case .vegetableListView:
            LazyView(VegetableListView())
        case let .vegetableView(vegetable):
            LazyView(VegetableView(vegetable: vegetable))
        case let .gardenView(bed):
            GardenBedView(bed: bed)
        case .gardenListView:
            GardenBedListView()
        case let .gardenBedVegetableList(squareID, bed):
            GardenBedVegetableSelection(squareID: squareID, bed: bed)
        }
    }
}

extension Route: Hashable {
//    static func == (lhs: Route, rhs: Route) -> Bool {
//        return true
//    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.hashValue)
    }
}
