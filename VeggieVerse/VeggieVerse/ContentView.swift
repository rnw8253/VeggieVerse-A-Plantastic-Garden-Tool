//
//  ContentView.swift
//  VeggieVerse
//
//  Created by Ryan Weber on 2/24/24.
//

import SwiftUI
import RealmSwift
import SwiftUI

struct ContentView: View {
    @ObservedObject var appState = AppState()
    @ObservedObject var data = LoadDataModel()
    @ObservedObject var realmManager = RealmManager()
    var body: some View {
        NavigationStack(path: $appState.path) {
            VStack {
                Text("Hello World")
                Button {
                    appState.path.append(Route.vegetableListView)
                } label: {
                    Text("Vegetables")
                }

            }
            .listStyle(.grouped)
            .navigationBarTitle("Nothing", displayMode: .inline)
            .padding(.top, 5)
            .navigationDestination(for: Route.self) { $0 }
        }
        .environmentObject(data)
        .environmentObject(appState)
        .environmentObject(realmManager)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
