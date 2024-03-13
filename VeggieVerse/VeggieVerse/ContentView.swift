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
                    print(userLocation!.getPlantingDates(for: .spring, vegetable: "Tomatoes")!)
                } label: {
                    Text("Location info")
                }
//                let _ = print("\(data.vegetables[0].companionPlants!.badCompanionPlants[0].name)_thumbnail")
                
                Button {
                    realmManager.updateUserLocationWithDates(zipcode: "73301")
                } label: {
                    Text("Update Zip")
                }
                
//                Button {
//                    let herbs: [String] = ["Basil", "Bay Leaves", "Chamomile", "Chives", "Cilantro", "Dandelion Greens", "Dill", "Lavender", "Lemon Balm", "Lemongrass", "Marjoram", "Mint", "Oregano", "Parsley", "Rosemary", "Sage", "Sorrel", "Stevia", "Tarragon", "Thyme"]
//                    let herbs2 = ["Cat Grass", "Chickweed", "Comfrey", "Mullein", "St. John's Wort", "Watercress", "Bee Balm", "Borage", "Calendula", "Catnip", "Chervil", "Chia", "Chickpea", "Edamame", "Fenugreek", "Ginger", "German Chamomile", "Hyssop", "Lemon Verbena", "Nasturtium", "Orach", "Parsley", "Popcorn", "Prickly Pear", "Salvia", "Summer Savory", "Sunflower", "Sweet Bay", "Tatsoi", "Yarrow"]
//
//                    let vegetables: [String] = ["Artichokes", "Arugula", "Asparagus", "Beets", "Bell Peppers", "Bok Choy", "Broccoli", "Brussels Sprouts", "Cabbage", "Carrots", "Cauliflower", "Celery", "Collard Greens", "Corn", "Cucumbers", "Eggplant", "Endive", "Escarole", "Fennel", "Garlic", "Green Beans", "Kale", "Kohlrabi", "Leeks", "Lettuce", "Mustard Greens", "Okra", "Onions", "Parsnips", "Peas", "Potatoes", "Pumpkins", "Radicchio", "Radishes", "Rutabagas", "Spinach", "Squash", "Sweet Potatoes", "Swiss Chard", "Tomatoes", "Turnips", "Watermelons", "Zucchini"]
//                    let vegetables2 = ["Fava Beans", "Chard", "Chinese Broccoli", "Scallions (Green Onions)", "Onion Walla Walla", "Shallot", "Bean Bush", "Bean Pole", "Cabbage Napa", "Cardoon", "Chayote", "Mizuna", "Jicama", "Loofah", "Moringa", "Peanut", "Tomatillo", "Water Spinach", "Tatsoi"]
//
//                    let fruits: [String] = ["Apples", "Apricots", "Avocados", "Bananas", "Blackberries", "Blueberries", "Cantaloupes", "Cherries", "Cranberries", "Figs", "Grapefruits", "Grapes", "Kiwis", "Lemons", "Limes", "Mangoes", "Oranges", "Papayas", "Peaches", "Pears", "Pineapples", "Plums", "Raspberries", "Strawberries", "Watermelons"]
//                    let fruits2 = ["Elderberry", "Feverfew", "Currant", "Ground Cherry", "Hibiscus", "Honeydew", "Jicama", "Lemon Verbena", "Tamarillo", "Tzimbalo", "Wonderberry"]
//
//                    createEmptyJSONFiles(inDirectory: URL(filePath: "/Users/Ryan/Desktop/VeggieVerse-A-Plantastic-Garden-Tool/VeggieVerse/VeggieVerse/Models/Vegetable/VegetableJSONs"), withFileNames: vegetables2)
//                } label: {
//                    Text("Read JSON")
//                }


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
