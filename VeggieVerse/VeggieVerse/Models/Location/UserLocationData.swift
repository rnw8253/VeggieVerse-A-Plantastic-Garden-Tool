//
//  UserLocationData.swift
//  VeggieVerse
//
//  Created by Ryan Weber on 3/4/24.
//

import Foundation
import RealmSwift



enum Season {
    case spring
    case fall
}
class UserLocation: Object {
    @Persisted var zipcode: String = ""
    @Persisted var hardinessZone: HardinessZone?
    @Persisted var plantingDates: PlantingDates?
    @Persisted var frostDates: FrostDates?
    
    func getPlantingDates(for season: Season, vegetable: String) -> PlantingRow? {
         guard let plantingDates = season == .spring ? plantingDates?.spring : plantingDates?.fall else {
             return nil
         }
         for row in plantingDates.rows {
             if row.crop.lowercased() == vegetable.lowercased() {
                 return row
             }
         }
         return nil
     }
    
    func checkIndoorDates(vegetable: String) -> Bool {
        let fallPlantingDates = getPlantingDates(for: .fall, vegetable: vegetable)
        let springPlantingDates = getPlantingDates(for: .spring, vegetable: vegetable)
        if fallPlantingDates != nil {
            if fallPlantingDates!.indoor != "N/A" {
                return true
            }
        }
        if springPlantingDates != nil {
            if springPlantingDates!.indoor != "N/A" {
                return true
            }
        }
        return false
    }
    
    func checkOutdoorDates(vegetable: String) -> Bool {
        let fallPlantingDates = getPlantingDates(for: .fall, vegetable: vegetable)
        let springPlantingDates = getPlantingDates(for: .spring, vegetable: vegetable)
        if fallPlantingDates != nil {
            if fallPlantingDates!.outdoor != "N/A" {
                return true
            }
        }
        if springPlantingDates != nil {
            if springPlantingDates!.outdoor != "N/A" {
                return true
            }
        }
        return false
    }
    
}
