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
        self.vegetables = loadVegetablesFromBundle()
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
