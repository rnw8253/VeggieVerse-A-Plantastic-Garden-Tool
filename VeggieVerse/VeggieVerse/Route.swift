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
}

extension Route: View {
    var body: some View {
        switch self {
        case .vegetableListView:
            VegetableListView()
        case let .vegetableView(vegetable):
            VegetableView(vegetable: vegetable)
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
