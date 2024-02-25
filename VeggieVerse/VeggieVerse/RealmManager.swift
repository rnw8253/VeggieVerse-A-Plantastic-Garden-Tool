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
}
