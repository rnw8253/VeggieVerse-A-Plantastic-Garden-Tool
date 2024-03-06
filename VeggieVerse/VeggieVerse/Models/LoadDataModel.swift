//
//  LoadDataModel.swift
//  VeggieVerse
//
//  Created by Ryan Weber on 2/25/24.
//

import Foundation
import RealmSwift

//class LoadDataModel: ObservableObject {
//    @Published var vegetables: Results<Vegetable>
//    init() {
//        let config = Realm.Configuration(fileURL: Bundle.main.url(forResource: "data", withExtension: "realm"), readOnly: true)
//        // Open the Realm with the configuration
//        let realm = try! Realm(configuration: config)
//        self.vegetables = realm.objects(Vegetable.self)
//    }
//}


class LoadDataModel: ObservableObject {
    @Published var vegetables: [Vegetable]
    
    init() {
        self.vegetables = convertJSON()
    }
}


func convertJSON() -> [Vegetable] {
    guard let url = Bundle.main.url(forResource: "Vegetables", withExtension: "json") else {
        print("JSON file not found")
        return []
    }
    do {
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.userInfo[CodingUserInfoKey(rawValue: "nestedContainerType")!] = CompanionPlants.self
        let plants = try decoder.decode([Vegetable].self, from: data)
        return plants
    } catch {
        print("Error decoding JSON: \(error)")
        return []
    }
}
