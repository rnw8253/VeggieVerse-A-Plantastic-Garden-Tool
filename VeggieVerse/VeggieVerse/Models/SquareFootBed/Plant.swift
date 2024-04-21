//
//  Plant.swift
//  VeggieVerse
//
//  Created by Ryan Weber on 4/15/24.
//

import Foundation
import RealmSwift

class Plant: Object, ObjectKeyIdentifiable, Codable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var plant: Vegetable
    @Persisted var sowDate: Date?
    @Persisted var sowType: SowType = .unsown
    convenience init(plant: Vegetable) {
        self.init()
        self.plant = plant
    }
}

enum SowType: String, PersistableEnum, Hashable, Codable {
    case indoor
    case outdoor
    case transplant
    case unsown
}

