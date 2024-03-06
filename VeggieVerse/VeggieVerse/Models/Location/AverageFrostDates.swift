//
//  AverageFrostDates.swift
//  VeggieVerse
//
//  Created by Ryan Weber on 3/4/24.
//

import Foundation
import RealmSwift
import SwiftSoup

class FrostDates: Object, Codable, Identifiable  {
    @Persisted var climateStation: String
    @Persisted var altitude: String
    @Persisted var lastSpringFrost: String
    @Persisted var firstFallFrost: String
    @Persisted var growingSeason: String
}

func getFrostDates(for zipcode: String, completion: @escaping (FrostDates?, Error?) -> Void) {
    let urlString = "https://www.almanac.com/gardening/frostdates/zipcode/\(zipcode)"
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
            
            let tableHtml = try doc.select("table#frostdates_table").first()!
            let columns = try tableHtml.select("td")
            
            let frostDate = FrostDates()
            for (i, column) in zip(columns.indices, columns) {
                switch i {
                case 0:
                    frostDate.climateStation = try column.text()
                case 1:
                    frostDate.altitude = try column.text()
                case 2:
                    frostDate.lastSpringFrost = try column.text()
                case 3:
                    frostDate.firstFallFrost = try column.text()
                case 4:
                    frostDate.growingSeason = try column.text()
                default:
                    break
                }
            }
            print(frostDate)
            completion(frostDate, nil)
        } catch {
            completion(nil, error)
        }
    }
    
    task.resume()
}

// Function to lookup frost dates for a given zipcode and return FrostDates object
func lookupFrostDates(for zipcode: String) -> FrostDates? {
    var frostDates: FrostDates?
    let semaphore = DispatchSemaphore(value: 0)
    
    getFrostDates(for: zipcode) { fetchedFrostDates, error in
        defer { semaphore.signal() }
        if let fetchedFrostDates = fetchedFrostDates {
            frostDates = fetchedFrostDates
        } else if let error = error {
            print("Error fetching frost dates: \(error)")
        }
    }
    
    _ = semaphore.wait(timeout: .distantFuture)
    return frostDates
}
