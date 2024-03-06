//
//  PlantSowDates.swift
//  VeggieVerse
//
//  Created by Ryan Weber on 3/3/24.
//

import Foundation
import RealmSwift
import SwiftSoup

class PlantingRow: Object, Codable, Identifiable  {
    @Persisted var crop: String
    @Persisted var indoor: String
    @Persisted var transplant: String
    @Persisted var outdoor: String
    @Persisted var lastDate: String
}

class PlantingTable: Object, Codable, Identifiable {
    @Persisted var title: String = ""
    @Persisted var rows = RealmSwift.List<PlantingRow>()
}

class PlantingDates: Object, Codable, Identifiable {
    @Persisted var spring: PlantingTable?
    @Persisted var fall: PlantingTable?
}

func getPlantingDates(for zipcode: String, completion: @escaping (PlantingDates?, Error?) -> Void) {
    let urlString = "https://www.almanac.com/gardening/planting-calendar/zipcode/\(zipcode)"
    guard let url = URL(string: urlString) else {
        completion(nil, NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
        return
    }

    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        guard let data = data, error == nil else {
            completion(nil, error)
            return
        }
        
        do {
            let html = String(data: data, encoding: .utf8)
            let doc = try SwiftSoup.parse(html ?? "")
            
            let plantingDates = PlantingDates()
            
            // Select tables following h2 headers with specific text
            let springHeader = try doc.select("h2:contains(Planting Dates for Spring)")
            let fallHeader = try doc.select("h2:contains(Planting Dates for Fall)")
            
            var springTable = PlantingTable()
            var fallTable = PlantingTable()
            
            if let springHeaderText = try? springHeader.text() {
                springTable.title = springHeaderText
            }
            
            if let fallHeaderText = try? fallHeader.text() {
                fallTable.title = fallHeaderText
            }
            
            guard let springNextTable = try? springHeader.first()?.nextElementSibling(),
                  let fallNextTable = try? fallHeader.first()?.nextElementSibling() else {
                completion(nil, NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to find planting tables"]))
                return
            }
            
            springTable = try parsePlantingTable(from: springNextTable)
            fallTable = try parsePlantingTable(from: fallNextTable)
            
            plantingDates.spring = springTable
            plantingDates.fall = fallTable
            
            completion(plantingDates, nil)
        } catch {
            completion(nil, error)
        }
    }
    
    task.resume()
}

// Helper method to parse planting table from HTML element
private func parsePlantingTable(from element: Element) throws -> PlantingTable {
    let table = PlantingTable()
    guard let rows = try? element.select("tr") else {
        throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to parse planting table"])
    }
    
    var newRow = PlantingRow()
    for row in rows {
        newRow = PlantingRow()
        newRow.crop = try row.select("th").text()
        
        guard let columns = try? row.select("td") else { continue }
        
        for (i, column) in zip(columns.indices, columns) {
            let start = try column.html().split(separator: "<br />")
            let text = start.isEmpty ? "" : try SwiftSoup.parse(String(start[0])).text()
            switch i {
            case 0:
                newRow.indoor = text
            case 1:
                newRow.transplant = text
            case 2:
                newRow.outdoor = text
            case 3:
                newRow.lastDate = text
            default:
                break
            }
        }
        table.rows.append(newRow)
    }
    return table
}

// Function to lookup planting dates for a given zipcode and return PlantingDates object
func lookupSowDates(for zipcode: String) -> PlantingDates? {
    var plantingDates: PlantingDates?
    let semaphore = DispatchSemaphore(value: 0)
    
    getPlantingDates(for: zipcode) { fetchedPlantingDates, error in
        defer { semaphore.signal() }
        if let fetchedPlantingDates = fetchedPlantingDates {
            plantingDates = fetchedPlantingDates
        } else if let error = error {
            print("Error fetching planting dates: \(error)")
        }
    }
    
    _ = semaphore.wait(timeout: .distantFuture)
    return plantingDates
}
