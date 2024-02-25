//
//  ContentView.swift
//  VeggieVerseDatabase
//
//  Created by Ryan Weber on 2/25/24.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    @State var vegetables = RealmSwift.List<Vegetable>()
    var body: some View {
        VStack {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Hello, world!")
                    .task {
                        do {
                            let veg = try await getVegetables()
                            for vegetable in veg {
                                vegetables.append(vegetable.generateRealmVegetable())
                            }
                            // Realm
                            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true, shouldCompactOnLaunch: { totalBytes, usedBytes in
                                let oneHundredMB = 100 * 1024 * 1024
                                return (totalBytes > oneHundredMB) && (Double(usedBytes) / Double(totalBytes)) < 0.5
                            })
                            Realm.Configuration.defaultConfiguration = config
                            let realm = try! await Realm()
                            try realm.write {
                                realm.deleteAll()
                            }
                            for data in vegetables {
                                try realm.write {
                                    realm.add(data)
                                }
                            }
                            print("Finshed Writing to File")
                            print("Realm is located at:", realm.configuration.fileURL!)
                        } catch {
                            print(error)
                            print("Error")
                        }
                    }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
