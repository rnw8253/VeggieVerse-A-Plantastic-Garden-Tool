//
//  Vegetable.swift
//  VeggieVerseDatabase
//
//  Created by Ryan Weber on 2/25/24.
//

import Foundation
import SwiftUI
import RealmSwift
import SwiftyJSON
import SwiftSoup

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
class VegetableJSON: Object, Codable, Identifiable {
    @Persisted var VegetableId: Int
    @Persisted var VegetableCode: String
    @Persisted var CatalogId: Int
    @Persisted var Name: String
    @Persisted var Description: String
    @Persisted var ThumbnailImage: String
    @Persisted var SeedDepth: String
    @Persisted var GerminationSoilTemp: String
    @Persisted var DaysToGermination: Int
    @Persisted var SowIndoors: String
    @Persisted var SowOutdoors: String
    @Persisted var PhRange: String
    @Persisted var GrowingSoilTemp: String
    @Persisted var SpacingBeds: String
    @Persisted var Watering: String
    @Persisted var Light: String
    @Persisted var GoodCompanions: String
    @Persisted var BadCompanions: String
    @Persisted var SowingDescription: String
    @Persisted var GrowingDescription: String
    @Persisted var HarvestDescription: String
    @Persisted var Season: String
    @Persisted var DaysToHarvestSeeds: Int
    @Persisted var DaysToHarvestSeedlings: Int
    
    func generateRealmVegetable() -> Vegetable {
        let vegetable = Vegetable()
        vegetable.vegetableId = VegetableId
        vegetable.vegetableCode = VegetableCode
        vegetable.catalogId = CatalogId
        vegetable.name = Name
        vegetable.vegetableDescription = Description
        vegetable.thumbnailImage = ThumbnailImage
        vegetable.seedDepth = SeedDepth
        vegetable.germinationSoilTemp = GerminationSoilTemp
        vegetable.daysToGermination = DaysToGermination
        vegetable.sowIndoors = SowIndoors
        vegetable.sowOutdoors = SowOutdoors
        vegetable.phRange = PhRange
        vegetable.growingSoilTemp = GrowingSoilTemp
        vegetable.spacingBeds = SpacingBeds
        vegetable.watering = Watering
        vegetable.light = Light
        for comp in GoodCompanions.split(separator: ", ") {
            vegetable.goodCompanions.append(String(comp).capitalized)
        }
        for comp in BadCompanions.split(separator: ", ") {
            vegetable.badCompanions.append(String(comp).capitalized)
        }
        vegetable.sowingDescription = SowingDescription
        vegetable.growingDescription = GrowingDescription
        vegetable.harvestDescription = HarvestDescription
        let temp = Season.replacingOccurrences(of: ", ", with: ",")
        for s in temp.split(separator: ",") {
            vegetable.season.append(String(s).capitalized)
        }
        vegetable.daysToHarvestSeeds = DaysToHarvestSeeds
        vegetable.daysToHarvestSeedlings = DaysToHarvestSeedlings
        return vegetable
    }
}




func getVegetables() async throws -> [VegetableJSON] {
    let configuration = URLSessionConfiguration.default
    guard let url = URL(string: "http://highoncoding.com/vegetable/getcatalog") else {
        throw AllErrors.invalidURL
    }
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
//    request.setValue("fd56500f-8501-4078-85df-67eadc7109c9", forHTTPHeaderField: "Authorization")
    
    let (data, _) = try await URLSession(configuration: configuration).data(for: request)
//    let _ = print(JSON(data))
    do {
        let decoder = JSONDecoder()
        return try decoder.decode([VegetableJSON].self, from: data)
    } catch {
        throw AllErrors.invalidData
    }
}


enum AllErrors: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}
