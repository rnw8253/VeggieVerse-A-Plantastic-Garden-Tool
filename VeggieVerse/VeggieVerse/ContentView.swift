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
    @StateObject var locationDataManager = LocationDataManager()
    var body: some View {
        NavigationStack(path: $appState.path) {
            VStack {
                switch locationDataManager.locationManager.authorizationStatus {
                case .authorizedWhenInUse:
                    Text("Your current location is:")
                    Text("Latitude: \(locationDataManager.locationManager.location?.coordinate.latitude.description ?? "Error loading")")
                    Text("Longitude: \(locationDataManager.locationManager.location?.coordinate.longitude.description ?? "Error loading")")
                    
                case .restricted, .denied:
                    Text("Current location data was restricted or denied.")
                case .notDetermined:
                    Text("Finding your location...")
                    ProgressView()
                default:
                    ProgressView()
                }
                Button {
                    appState.path.append(Route.vegetableListView)
                } label: {
                    Text("Vegetables")
                }
                Button {
                    realmManager.createUserLocationIfNeeded(zipcode: "64068")
                    let userLocation = realmManager.loadUserLocation()
                    print(userLocation?.getPlantingDates(for: .spring, vegetable: "Tomatoes"))
                } label: {
                    Text("Location info")
                }

                Button {
                    realmManager.updateUserLocationWithDates(zipcode: "73301")
                } label: {
                    Text("Update Zip")
                }



//                ScrollView{
//                            ForEach(UIFont.familyNames.sorted(), id: \.self) { family in
//                                let names = UIFont.fontNames(forFamilyName: family)
//                                ForEach(names, id: \.self) { name in
//                                    Text(name).font(Font.custom(name, size: 20))
//                                }
//                            }
//                        }
                
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
        .onAppear {
            realmManager.openRealm()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
