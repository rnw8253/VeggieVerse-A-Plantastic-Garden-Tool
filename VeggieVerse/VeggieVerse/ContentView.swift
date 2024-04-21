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
    @StateObject var locationDataManager = LocationDataManager()
    @ObservedObject var appState = AppState.shared
    var body: some View {
        NavigationStack(path: $appState.path) {
            VStack {
//                switch locationDataManager.locationManager.authorizationStatus {
//                case .authorizedWhenInUse:
//                    Text("Your current location is:")
//                    Text("Latitude: \(locationDataManager.locationManager.location?.coordinate.latitude.description ?? "Error loading")")
//                    Text("Longitude: \(locationDataManager.locationManager.location?.coordinate.longitude.description ?? "Error loading")")
//
//                case .restricted, .denied:
//                    Text("Current location data was restricted or denied.")
//                case .notDetermined:
//                    Text("Finding your location...")
//                    ProgressView()
//                default:
//                    ProgressView()
//                }
                
                Button {
                    var (springIndoor, springTransplant, springOutdoor, lastSowDate, fallTransplant, fallOutdoor, daysToMaturity, frostTolerance) = CalculateSpringSowDateString(vegetable: LoadDataModel.shared.vegetables[0])
                    print(LoadDataModel.shared.vegetables[0].name)
                    print(springIndoor)
                    print(springTransplant)
                    print(springOutdoor)
                    print(lastSowDate)
                    print(fallOutdoor)
                    print(fallTransplant)
                    print(daysToMaturity)
                    print(frostTolerance)

                    (springIndoor, springTransplant, springOutdoor, lastSowDate, fallTransplant, fallOutdoor, daysToMaturity, frostTolerance) = CalculateSpringSowDateString(vegetable: LoadDataModel.shared.vegetables[79])
                    print(LoadDataModel.shared.vegetables[79].name)
                    print(springIndoor)
                    print(springTransplant)
                    print(springOutdoor)
                    print(lastSowDate)
                    print(fallOutdoor)
                    print(fallTransplant)
                    print(daysToMaturity)
                    print(frostTolerance)

                } label: {
                    Text("DATES")
                }

                
                Button {
                    AppState.shared.path.append(Route.vegetableListView)
                } label: {
                    Text("Vegetables")
                }

                NavigationLink(value: Route.gardenListView) {
                    Text("GARDEN BED")
                }
                Button {
                    let bed = GenerateBed()
                    bed.printPlantsInSquares()
                    let realm = try! Realm()
                    // Perform the write operation within a write transaction
                    try! realm.write {
                        realm.add(bed)
                    }
                    print("Create bed Object")
                } label: {
                    Text("ADD GARDEN BED")
                }
                Button {
                    for vegetable in LoadDataModel.shared.vegetables {
                        for name in vegetable.pests {
                            var flag = false
                            for pest in LoadDataModel.shared.pests {
                                    if name == pest.name {
                                    flag = true
                                }
                            }
                            if !flag {
                                print("\(name) in \(vegetable.name)")
                            }
                        }
                    }
                } label: {
                    Text("CHECK PESTS")
                }
                
                Button {
                    for pest in LoadDataModel.shared.pests {
                        var flag = true
                        for vegetbale in LoadDataModel.shared.vegetables {
                            for name in vegetbale.pests {
                                if pest.name == name {
                                    flag = false
                                    break
                                }
                            }
                        }
                        if flag {
                            let _ = print(pest.name)
                        }
                    }
                    
                } label: {
                    Text("UNUSED PESTS")
                }
                Button {
                    for vegetable in LoadDataModel.shared.vegetables {
                        for name in vegetable.diseases {
                            var flag = false
                            for disease in LoadDataModel.shared.diseases {
                                if name == disease.name {
                                    flag = true
                                }
                            }
                            if !flag {
                                print("\(name) in \(vegetable.name)")
                            }
                        }
                    }
                } label: {
                    Text("CHECK DISEASE")
                }
                
                Button {
                    for disease in LoadDataModel.shared.diseases {
                        var flag = true
                        for vegetbale in LoadDataModel.shared.vegetables {
                            for name in vegetbale.diseases {
                                if disease.name == name {
                                    flag = false
                                    break
                                }
                            }
                        }
                        if flag {
                            let _ = print(disease.name)
                        }
                    }
                    
                } label: {
                    Text("UNUSED DISEASE")
                }
                
                
                Button {
                    for index in LoadDataModel.shared.vegetables.indices {
                        print("\(index) \(LoadDataModel.shared.vegetables[index].name)")
                    }
                } label: {
                    Text("PRINT VEGETABLE INDEXES")
                }
                
                Button {
                    // Create a set of all vegetable names for efficient lookup
                    let allVegetableNames = Set(LoadDataModel.shared.vegetables.map { $0.name })
                    var ignoreCompanionNames: [String] = ["Marigold","Anise","Wheat","Turmeric","Rhubarb","Black Nightshade","Brassicas","Beans","Melons","Alliums","Peppers","Grass","Walnuts","Nightshades","Herbs","Citrus","Legumes","Allelopathic Herbs", "Aromatic Herbs","Wheatgrass","Clover","Daffodils","Sagebrush","Yucca","Agave","Buffelgrass","Tansy","Horseradish","Wintergreen","Lingonberries","Peat Moss","Sweet Alyssum","Azaleas","Lupines","Chrysanthemums","Chicory","Valerian","Toxic Plants","Fruit Trees","Aster","Taro","Caraway","Heather","Ferns","Oat Grass","Echinacea","Bermuda Grass","Wormwood","Peppermint","Vegetables","Nitrogen-Fixing Plants","Shallow-Rooted Plants","Plants Prone to Overcrowding","Root Crops","Dynamic Accumulators","Shade-Tolerant Plants"]

                    // Iterate over each vegetable
                    for vegetable in LoadDataModel.shared.vegetables {
                        // Check each companion in the good companion list
                        for companion in vegetable.companionPlants!.goodCompanionPlants {
                            if ignoreCompanionNames.contains(companion.name) {
                                continue
                            }
                            // Print the companion if it's not in the list of vegetables
                            if !allVegetableNames.contains(companion.name) {
                                print("\(vegetable.name) has a missing companion: \(companion.name)")
                            }
                        }
                        
                        // Check each companion in the bad companion list
                        for companion in vegetable.companionPlants!.badCompanionPlants {
                            if ignoreCompanionNames.contains(companion.name) {
                                continue
                            }
                            // Print the companion if it's not in the list of vegetables
                            if !allVegetableNames.contains(companion.name) {
                                print("\(vegetable.name) has a missing companion: \(companion.name)")
                            }
                        }
                    }
                } label: {
                    Text("COMPANIONS")
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
//        .environmentObject(data)
        .navigationViewStyle(StackNavigationViewStyle())

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
