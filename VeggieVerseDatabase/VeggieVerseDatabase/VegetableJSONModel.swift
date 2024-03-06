//
//  File.swift
//  VeggieVerseDatabase
//
//  Created by Ryan Weber on 2/27/24.
//

import Foundation
import RealmSwift


class Plant: Object, Codable, Identifiable {
    @Persisted var plantName: String
    @Persisted var descriptionText: String
    @Persisted var varieties: RealmSwift.List<Variety>
    @Persisted var sowingAndPlanting: SowingAndPlanting?
    @Persisted var careAndMaintenance: CareAndMaintenance?
    @Persisted var harvestingAndStorage: HarvestingAndStorage?
    @Persisted var companionPlants: CompanionPlants?
    @Persisted var seasonalNotes: String
    @Persisted var commonProblems: RealmSwift.List<Problem>
    @Persisted var tipsAndTricks: RealmSwift.List<String>
    @Persisted var linksToAdditionalResources: RealmSwift.List<ResourceLink>
    
    enum CodingKeys: String, CodingKey {
        case plantName
        case descriptionText = "description"
        case varieties
        case sowingAndPlanting
        case careAndMaintenance
        case harvestingAndStorage
        case companionPlants
        case seasonalNotes
        case commonProblems
        case tipsAndTricks
        case linksToAdditionalResources
    }
}

class Variety: Object, Codable {
    @Persisted var name: String
    @Persisted var descriptionText: String
    @Persisted var image: String
    @Persisted var category: String
    @Persisted var growthHabit: String
    @Persisted var growthType: String
    @Persisted var supportType: String
    @Persisted var daysToHarvest: String
    @Persisted var germinationSoilTemp: String
    @Persisted var growingSoilTemp: String
    @Persisted var squareFootPlantingRecommendations: String
    
    enum CodingKeys: String, CodingKey {
        case descriptionText = "description"
        case name
        case image
        case category
        case growthHabit
        case growthType
        case supportType
        case daysToHarvest
        case germinationSoilTemp
        case growingSoilTemp
        case squareFootPlantingRecommendations
    }
}

class SowingAndPlanting: Object, Codable {
    @Persisted var sowingIndoors: SowingMethod?
    @Persisted var sowingOutdoors: SowingMethod?
    @Persisted var spacingRequirements: String
    @Persisted var seedDepth: String
    @Persisted var pHRange: String
    @Persisted var germinationSoilTemp: String
    @Persisted var growingSoilTemp: String
    @Persisted var growingDescription: String
    @Persisted var harvestDescription: String
    @Persisted var daysToHarvest: String
    @Persisted var season: String
}

class SowingMethod: Object, Codable {
    @Persisted var methods = RealmSwift.List<String>()
    @Persisted var bestTimeToSow: String
    @Persisted var transplantInformation: TransplantInformation?
    @Persisted var sowingDescription: String
}

class TransplantInformation: Object, Codable {
    @Persisted var transplantTime: String
    @Persisted var recommendedSize: String
}

class CareAndMaintenance: Object, Codable {
    @Persisted var wateringNeeds: String
    @Persisted var soilFertility: String
    @Persisted var pestAndDiseaseManagement: String
    @Persisted var pruningOrTrainingRequirements: String
}

class HarvestingAndStorage: Object, Codable {
    @Persisted var timeToMaturity: String
    @Persisted var harvestingTips: String
    @Persisted var storageRecommendations: String
}

class CompanionPlants: Object, Codable {
    var goodCompanionPlants = RealmSwift.List<String>()
    var badCompanionPlants = RealmSwift.List<String>()
}

class Problem: Object, Codable {
    @Persisted var name: String
    @Persisted var descriptionText: String
   
    enum CodingKeys: String, CodingKey {
        case name
        case descriptionText = "description"
    }
}

class ResourceLink: Object, Codable {
    @Persisted var title: String
    @Persisted var url: String
}


func convertJSON() -> [Plant] {
    // Check if the JSON file exists
    guard let url = Bundle.main.url(forResource: "Vegetables", withExtension: "json") else {
        print("JSON file not found")
        return []
    }
    
    do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.userInfo[CodingUserInfoKey(rawValue: "nestedContainerType")!] = CompanionPlants.self
            let plants = try decoder.decode([Plant].self, from: data)
            return plants
        } catch {
            print("Error decoding JSON: \(error)")
            return []
        }
}
