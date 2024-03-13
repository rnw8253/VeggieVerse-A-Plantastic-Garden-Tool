//
//  VegetableModel.swift
//  VeggieVerse
//
//  Created by Ryan Weber on 2/27/24.
//

import Foundation
import RealmSwift


class Vegetable: Object, Codable, Identifiable {
    @Persisted var name: String
    @Persisted var descriptionText: String
    @Persisted var varieties: String
    @Persisted var sowingAndPlanting: SowingAndPlanting?
    @Persisted var careAndMaintenance: CareAndMaintenance?
    @Persisted var harvestingAndStorage: HarvestingAndStorage?
    @Persisted var companionPlants: CompanionPlants?
    @Persisted var tipsAndTricks: RealmSwift.List<String>
    @Persisted var linksToAdditionalResources: RealmSwift.List<ResourceLink>
    @Persisted var thumbnailImageUrl: String
    @Persisted var backgroundImageUrl: String
    @Persisted var pests: RealmSwift.List<Pests>
    @Persisted var diseases: RealmSwift.List<Diseases>
    
    enum CodingKeys: String, CodingKey {
        case name = "plantName"
        case descriptionText = "description"
        case varieties
        case sowingAndPlanting
        case careAndMaintenance
        case harvestingAndStorage
        case companionPlants
        case tipsAndTricks
        case linksToAdditionalResources
        case thumbnailImageUrl
        case backgroundImageUrl
        case pests
        case diseases
    }
}


class SowingAndPlanting: Object, Codable {
    @Persisted var sowingIndoorsDescription: String
    @Persisted var sowingOutdoorsDescription: String
    @Persisted var spaceBetweenPlants: String
    @Persisted var spaceBetweenRows: String
    @Persisted var squareFootPlantingRecommendationsMin: Int
    @Persisted var squareFootPlantingRecommendationsMax: Int
    @Persisted var lifeCycle: String
    @Persisted var seedDepth: String
    @Persisted var pHRange: String
    @Persisted var germinationSoilTemp: String
    @Persisted var season: String
}

class CareAndMaintenance: Object, Codable {
    @Persisted var optimalSun: String
    @Persisted var growingSoilTemp: String
    @Persisted var growingDescription: String
    @Persisted var wateringNeeds: String
    @Persisted var soilFertility: String
    @Persisted var pruningRequirements: String
    @Persisted var supportRequirements: String
}

class HarvestingAndStorage: Object, Codable {
    @Persisted var daysToHarvest: String
    @Persisted var timeToMaturity: String
    @Persisted var storageRecommendations: String
    @Persisted var harvestDescription: String
}

class CompanionPlants: Object, Codable {
    var goodCompanionPlants = RealmSwift.List<CompanionPlant>()
    var badCompanionPlants = RealmSwift.List<CompanionPlant>()
}


class CompanionPlant: Object, Codable {
    @Persisted var name: String
    @Persisted var descriptionText: String
    enum CodingKeys: String, CodingKey {
        case name
        case descriptionText = "description"
    }
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

class Pests: Object, Codable {
    @Persisted var name: String
    @Persisted var descriptionText: String
    enum CodingKeys: String, CodingKey {
        case name
        case descriptionText = "description"
    }
}

class Diseases: Object, Codable {
    @Persisted var name: String
    @Persisted var descriptionText: String
    enum CodingKeys: String, CodingKey {
        case name
        case descriptionText = "description"
    }
}


