//
//  LoadDataModel.swift
//  VeggieVerse
//
//  Created by Ryan Weber on 2/25/24.
//

import Foundation
import RealmSwift

class LoadDataModel: ObservableObject {
    @Published var vegetables: Results<Vegetable>
    init() {
        let config = Realm.Configuration(fileURL: Bundle.main.url(forResource: "data", withExtension: "realm"), readOnly: true)
        // Open the Realm with the configuration
        let realm = try! Realm(configuration: config)
        self.vegetables = realm.objects(Vegetable.self)
    }
}
