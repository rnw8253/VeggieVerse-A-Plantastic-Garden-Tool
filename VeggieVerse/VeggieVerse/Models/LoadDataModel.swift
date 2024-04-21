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
    static let shared = LoadDataModel()
    @Published var vegetables: [Vegetable]
    @Published var diseases: [Disease]
    @Published var pests: [Pest]
    @Published var plantCategories: [String:[String]]
//    @Published var beneficial_pests: [Pest]
    init() {
        self.vegetables = loadVegetablesFromBundle()
        self.diseases = readDiseaseData(fromFile: "diseases")
        self.pests = readPestsData(fromFile: "pests")
        self.plantCategories = generatePlantCategories()
//        self.beneficial_pests = readPestsData(fromFile: "beneficial_insects")
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

func loadVegetablesFromBundle() -> [Vegetable] {
    var vegetables = [Vegetable]()
    
    // Get all the JSON files in the bundle
    if let bundlePath = Bundle.main.resourcePath {
        do {
            let jsonFiles = try FileManager.default.contentsOfDirectory(atPath: bundlePath).filter { $0.hasSuffix(".json") }
            
            // Loop over the JSON files
            for jsonFile in jsonFiles {
                // Get the full path of the JSON file
                let jsonFilePath = "\(bundlePath)/\(jsonFile)"
                
                // Read the data from the JSON file
                if let jsonData = FileManager.default.contents(atPath: jsonFilePath) {
                    // Decode the JSON data into a Vegetable object
                    let decoder = JSONDecoder()
                    do {
                        let vegetable = try decoder.decode(Vegetable.self, from: jsonData)
                        vegetables.append(vegetable)
                    } catch {
                        print("Error decoding JSON file: \(jsonFile). Error: \(error)")
                    }
                }
            }
        } catch {
            print("Error while enumerating JSON files: \(error)")
        }
    }
    
    return vegetables
}


func createEmptyJSONFiles(inDirectory directory: URL, withFileNames fileNames: [String]) {
    // Loop through the list of file names
    for fileName in fileNames {
        // Construct the file URL with .json extension
        let fileURL = directory.appendingPathComponent(fileName).appendingPathExtension("json")
        
        // Check if the file already exists
        if !FileManager.default.fileExists(atPath: fileURL.path) {
            // Create an empty file at the specified URL
            FileManager.default.createFile(atPath: fileURL.path, contents: nil, attributes: nil)
            
            print("Empty JSON file created: \(fileURL.lastPathComponent)")
        } else {
            print("File already exists: \(fileURL.lastPathComponent)")
        }
    }
}

func readDiseaseData(fromFile fileName: String) -> [Disease] {
    guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
        print("File not found.")
        return []
    }
    
    do {
        let data = try Data(contentsOf: url)
        let diseases = try JSONDecoder().decode([Disease].self, from: data)
        return diseases
    } catch {
        print("Error decoding JSON: \(error)")
        return []
    }
}

func readPestsData(fromFile fileName: String) -> [Pest] {
    guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
        print("File not found.")
        return []
    }
    
    do {
        let data = try Data(contentsOf: url)
        let diseases = try JSONDecoder().decode([Pest].self, from: data)
        return diseases
    } catch {
        print("Error decoding JSON: \(error)")
        return []
    }
}

func generatePlantCategories() -> [String:[String]] {
    var categories: [String:[String]] = [:]
    categories["Melons"] = ["Cantaloupes", "Honeydew", "Watermelos", "Galia Melon", "Charentais Melon", "Casaba Melon", "Santa Claus Melon", "Persian Melon", "Crenshaw Melon", "Canary Melon", "Hami Melon", "Sprite Melon", "Korean Melon"]
    categories["Beans"] = ["Green Beans", "Kidney Beans", "Black Beans", "Navy Beans", "Pinto Beans", "Lima Beans", "SoyBeans", "Chickpeas", "Lentils", "Black-eyed peas", "Adzuki Beans", "Fava Beans", "Pole Beans"]
    categories["Brassicas"] = ["Broccoli", "Cabbage", "Cauliflower", "Kale", "Brussels Sprouts", "Collard greens", "Turnips", "Rutabagas", "Bok Choy", "Kohlrabi", "Radishes"]
    categories["Nitrogen-Fixing Plants"] = ["Alfalfa", "Alder Tree", "Green Beans", "Kidney Beans", "Black Beans", "Navy Beans", "Pinto Beans", "Lima Beans", "SoyBeans", "Chickpeas", "Lentils", "Black-eyed peas", "Adzuki Beans", "Fava Beans", "Pole Beans", "Birdsfoot trefoil", "Black Locust Tree", "Caragana", "Clover", "Cowpeas", "Crotalaria", "Lablab", "Lentils", "Lespedeza", "Lupines", "Peas", "Sesbania", "Sun hemp", "Vetch", "Wisteria"]
    categories["Alliums"] = ["Onions", "Garlic", "Leeks", "Shallot", "Chives", "Scallions", "Ramps", "Fennel", "Spring Onions"]
    categories["Peppers"] = ["Bell Peppers", "Chili Peppers", "Jalapeno", "Habanero", "Poblano", "Anaheim Pepper", "Serrano Pepper", "Cayenne Pepper", "Thai Pepper", "Shishito Pepper", "Ghost Pepper", "Scotch Bonnet", "Pimiento", "Paprika Pepper", "Banana Pepper", "Cherry Pepper", "Pepperoncini"]
    categories["Legumes"] = ["Green Beans", "Kidney Beans", "Black Beans", "Navy Beans", "Pinto Beans", "Lima Beans", "SoyBeans", "Chickpeas", "Lentils", "Black-eyed peas", "Adzuki Beans", "Fava Beans", "Pole Beans", "Peas", "Lentils", "Peanuts", "Lima beans", "Cowpeas", "Mung beans", "Adzuki beans", "Pigeon peas", "Lupins", "Lablab", "Vetch", "Clover", "Alfalfa"]
    categories["Nightshades"] = ["Tomatoes", "Potatoes", "Eggplant", "Bell Peppers", "Chili Peppers", "Paprika", "Tomatillo", "Goji Berry", "Ground Cherry"]
    categories["Root Crops"] = ["Carrots", "Potatoes", "Beets", "Radishes", "Turnips", "Sweet Potatoes", "Parsnips", "Rutabagsa", "Yams", "Onions", "Garlic", "Ginger", "Turmeric", "Jicama", "Cassava", "Taro", "Jerusalem Artichoke", "Daikon", "Salsify", "Horseradish"]
    categories["Plants Prone to Overcrowding"] = ["Lettuce", "Spinach", "Carrots", "Radishes", "Beets", "Onions", "Garlic", "Peas", "Green Beans", "Kidney Beans", "Black Beans", "Navy Beans", "Pinto Beans", "Lima Beans", "SoyBeans", "Chickpeas", "Lentils", "Black-eyed peas", "Adzuki Beans", "Fava Beans", "Pole Beans", "Corn", "Cucumbers", "Zucchini", "Squash", "Pumpkins", "Melons", "Tomatoes", "Eggplant", "Bell Peppers", "Chili Peppers", "Jalapeno", "Habanero", "Poblano", "Anaheim Pepper", "Serrano Pepper", "Cayenne Pepper", "Thai Pepper", "Shishito Pepper", "Ghost Pepper", "Scotch Bonnet", "Pimiento", "Paprika Pepper", "Banana Pepper", "Cherry Pepper", "Pepperoncini", "Broccoli", "Cabbage", "Cauliflower", "Kale", "Brussels Sprouts", "Turnips"]
    categories["Dynamic Accumulators"] = ["Comfrey", "Nettle", "Borage", "Chamomile", "Yarrow", "Dandelion Greens", "Alder Trees", "Willow Trees", "Clover", "Vetch", "Rye", "Buckwheat", "Phacelia", "Sunflower", "Mustard", "Sorghum", "Pumpkins", "Squash", "Cantaloupes", "Honeydew", "Watermelos", "Galia Melon", "Charentais Melon", "Casaba Melon", "Santa Claus Melon", "Persian Melon", "Crenshaw Melon", "Canary Melon", "Hami Melon", "Sprite Melon", "Korean Melon", "Corn", "Kale", "Radishes"]
    categories["Shallow-Rooted Plants"] = ["Lettuce", "Spinach", "Radishes", "Arugula", "Chives", "Basil", "Cilantro", "Parsley", "Dill", "Thyme", "Oregano", "Marjoram", "Shallots", "Garlic", "Onions", "Lettuce", "Kale", "Swiss chard", "Endive", "Mesclun greens", "Mustard greens", "Asian greens", "Watercress", "Turnip greens", "Fennel", "Scallions", "Leeks", "Beets", "Carrots", "Radishes", "Parsnips", "Turnips"]
    return categories
}

