//
//  PlantHardinessZone.swift
//  VeggieVerse
//
//  Created by Ryan Weber on 3/3/24.
//
import Foundation
import RealmSwift
import SwiftCSV

// Define a struct to represent hardiness zone data
class HardinessZone: Object {
    @Persisted var zipcode: String
    @Persisted var zone: String
    @Persisted var temperatureRange: String
    @Persisted var zoneTitle: String
}


// Find hardiness zone data for a specific zipcode in the CSV file
func lookupPlantHardinessZone(for zipcode: String) -> HardinessZone? {
    guard let csvFileURL = Bundle.main.url(forResource: "hardiness_zones", withExtension: "csv") else {
        print("CSV file not found")
        return nil
    }
    
    do {
        let csv: CSV = try CSV<Named>(url: csvFileURL, delimiter: ",", encoding: .utf8, loadColumns: true)
        
        for row in csv.rows {
            if row["zipcode"] == zipcode {
                let newZone = HardinessZone()
                newZone.zipcode = zipcode
                newZone.zone = row["zone"]!
                newZone.zoneTitle = row["zonetitle"]!
                newZone.temperatureRange = row["trange"]!
                return newZone
            }
        
        }
        
        // If the specific zipcode is not found in the CSV file
        print("Zipcode \(zipcode) not found in the CSV file")
        return nil
    } catch {
        print("Error parsing CSV: \(error)")
        return nil
    }
}
