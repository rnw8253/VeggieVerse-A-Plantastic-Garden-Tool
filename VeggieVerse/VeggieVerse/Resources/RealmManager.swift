//
//  RealmManager.swift
//  VeggieVerse
//
//  Created by Ryan Weber on 2/25/24.
//

import Foundation
import RealmSwift

class RealmManager: ObservableObject {
    private(set) var localRealm: Realm?
    
    init() {
        openRealm()
    }
    
    func openRealm() {
        do {
            var config = Realm.Configuration(schemaVersion: 1)
            config.deleteRealmIfMigrationNeeded = true
            Realm.Configuration.defaultConfiguration = config
            localRealm = try Realm()
        } catch {
            print("Error opening Realm: \(error)")
        }
    }

    // Function to update user location with planting and frost dates for a given zipcode
    func updateUserLocationWithDates(zipcode: String) {
        guard let realm = localRealm else { return }
        guard let userLocation = realm.objects(UserLocation.self).first else { return }
        
        do {
            try realm.write {
                userLocation.zipcode = zipcode
                userLocation.hardinessZone = lookupPlantHardinessZone(for: zipcode)
                userLocation.plantingDates = lookupSowDates(for: zipcode)
                userLocation.frostDates = lookupFrostDates(for: zipcode)
            }
        } catch {
            print("Error updating user location: \(error)")
        }
    }
    
    // Function to create a new UserLocation object in Realm with the given zipcode
    func createUserLocationIfNeeded(zipcode: String) {
        guard let realm = localRealm else { return }
        
        // Check if a UserLocation object already exists in the database
        if realm.objects(UserLocation.self).isEmpty {
            // If no UserLocation object exists, create a new one and save it to the database
            let userLocation = UserLocation()
            userLocation.zipcode = zipcode
            userLocation.hardinessZone = lookupPlantHardinessZone(for: zipcode)
            userLocation.plantingDates = lookupSowDates(for: zipcode)
            userLocation.frostDates = lookupFrostDates(for: zipcode)
            do {
                try realm.write {
                    realm.add(userLocation)
                }
                print("UserLocation created and saved to Realm")
            } catch {
                print("Error creating UserLocation: \(error)")
            }
        } else {
            print("UserLocation already exists in Realm")
        }
    }
    
    // Function to load UserLocation object from Realm
    func loadUserLocation() -> UserLocation? {
        guard let realm = localRealm else {
            print("Error: Realm is not initialized")
            return nil
        }
        
        return realm.objects(UserLocation.self).first
    }
    
}
