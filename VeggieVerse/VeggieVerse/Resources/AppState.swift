//
//  AppState.swift
//  VeggieVerse
//
//  Created by Ryan Weber on 2/25/24.
//

import Foundation
import SwiftUI

class AppState: ObservableObject {
    static let shared = AppState()
    @Published var path = [Route]()
    
    func popToRoot() {
        path = []
    }
    
    func popXViews(_ x: Int) {
        if x <= path.count {
            path.removeLast(x)
        }
    }
    
    func push(to screen: Route) {
        path.append(screen)
    }

}
