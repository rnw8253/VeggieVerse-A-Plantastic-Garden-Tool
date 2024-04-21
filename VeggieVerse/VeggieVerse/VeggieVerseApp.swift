//
//  VeggieVerseApp.swift
//  VeggieVerse
//
//  Created by Ryan Weber on 2/24/24.
//

import SwiftUI

@main
struct VeggieVerseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(LoadDataModel.shared)
                .environmentObject(RealmManager.shared)
                .environmentObject(AppState.shared)
                .onAppear {
                    RealmManager.shared.openRealm()
                }
        }
    }
}
