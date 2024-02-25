//
//  Vegetable.swift
//  VeggieVerse
//
//  Created by Ryan Weber on 2/25/24.
//

import Foundation
import SwiftUI
import RealmSwift

class Vegetable: Object, Codable, Identifiable {
    @Persisted var vegetableId: Int
    @Persisted var vegetableCode: String
    @Persisted var catalogId: Int
    @Persisted var name: String
    @Persisted var vegetableDescription: String
    @Persisted var thumbnailImage: String
    @Persisted var seedDepth: String
    @Persisted var germinationSoilTemp: String
    @Persisted var daysToGermination: Int
    @Persisted var sowIndoors: String
    @Persisted var sowOutdoors: String
    @Persisted var phRange: String
    @Persisted var growingSoilTemp: String
    @Persisted var spacingBeds: String
    @Persisted var watering: String
    @Persisted var light: String
    @Persisted var goodCompanions: RealmSwift.List<String>
    @Persisted var badCompanions: RealmSwift.List<String>
    @Persisted var sowingDescription: String
    @Persisted var growingDescription: String
    @Persisted var harvestDescription: String
    @Persisted var season: RealmSwift.List<String>
    @Persisted var daysToHarvestSeeds: Int
    @Persisted var daysToHarvestSeedlings: Int
}
