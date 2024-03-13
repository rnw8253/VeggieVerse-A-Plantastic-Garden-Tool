//
//  VegetableView.swift
//  VeggieVerse
//
//  Created by Ryan Weber on 2/25/24.
//

import Foundation
import SwiftUI

struct VegetableView: View {
    let vegetable: Vegetable
    let curveVal: CGFloat = 50
    @EnvironmentObject var realmManager: RealmManager
    @State private var currentHeader = CurrentVegetableHeaderView.sowingAndPlanting
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                VegetableNavBarView(title: "", titleColor: .white, shadowColor: .black, openColor: .white, height: 170, curveVal: curveVal, backgroundImage: vegetable.backgroundImageUrl)
                    .frame(height: 110)
                VStack {
                    ZStack {
                        VStack {
                            Image("seeds2")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 60)
                            Spacer()
                        }
                        VStack(spacing: 0) {
                            ZStack {
                                CurveSidedRectangle(curveHeightTop: curveVal, curveHeightBottom: curveVal)
                                    .fill(Color.themeBackground)
                                    .shadow(color: .gray, radius: 20)
                                    .frame(height: 60)
//                                CurveSidedRectangle(curveHeightTop: curveVal, curveHeightBottom: curveVal)
//                                    .fill(Color.themeForeground)
//                                    .frame(height: 60)
//                                    .padding(.horizontal,20)
//                                    .overlay(
//                                        VStack {
//                                            Text(vegetable.name)
//                                                .font(Font.custom("AmericanTypewriter", size: 40))
//                                                .padding(.top, 40)
//                                                .foregroundColor(.black)
//                                            Text("Seed")
//                                                .font(Font.custom("AmericanTypewriter", size: 15))
//                                                .foregroundColor(.black)
//                                        }
//                                    )
//
                            }
                            ZStack {
                                CurveSidedRectangle(curveHeightTop: curveVal, curveHeightBottom: 0)
                                    .fill(Color.themeBackground)
                                    .shadow(radius: 30)
                                    .overlay(
                                        ScrollView {
                                            VStack {
                                                CurveSidedRectangle(curveHeightTop: curveVal, curveHeightBottom: curveVal)
                                                    .fill(Color.themeForeground)
                                                    .frame(height: 80)
                                                    .padding(.horizontal,20)
                                                    .overlay(
                                                        VStack {
                                                            Text(vegetable.name)
                                                                .font(Font.custom("AmericanTypewriter", size: 40))
                                                                .padding(.top, 40)
                                                                .foregroundColor(.black)
                                                            Text("Seed")
                                                                .font(Font.custom("AmericanTypewriter", size: 15))
                                                                .foregroundColor(.black)
                                                        }
                                                    )
//                                                NavigationLink(destination: VarietyPickerView(selectedVariety: $selectedVariety, varieties: Array(vegetable.varieties))) {
//                                                    CurveSidedRectangle(curveHeightTop: curveVal-10, curveHeightBottom: curveVal-15)
//                                                        .fill(Color.themeTertiary)
//                                                        .frame(height: 60)
//                                                        .padding(.horizontal,40)
//                                                        .padding(.vertical, 5)
//                                                        .overlay(
//                                                            VStack {
//                                                                Text(selectedVariety?.name ?? "Unselected")
//                                                                    .font(Font.custom("AmericanTypewriter", size: 25))
//                                                                    .padding(.top, 30)
//                                                                    .foregroundColor(.black)
//                                                                Text("Variety")
//                                                                    .font(Font.custom("AmericanTypewriter", size: 15))
//                                                                    .foregroundColor(.black)
//                                                            }
//                                                        )
//                                                }
                                                VegetableSectionHeaderView(currentHeader: $currentHeader, curveVal: curveVal, fillColor: Color.gradColor2)
                                                switch currentHeader {
                                                case .sowingAndPlanting:
                                                    SowingAndPlantingView(vegetable: vegetable, userLocation: realmManager.loadUserLocation())
                                                case .careAndMaintenance:
                                                    CareAndMaintenanceView(vegetable: vegetable)
                                                case .harvestAndStorage:
                                                    HarvestingAndStorageView(vegetable: vegetable)
                                                case .pests:
                                                    PestsView(vegetable: vegetable)
                                                case .disease:
                                                    DiseaseView(vegetable: vegetable)
                                                case .companions:
                                                    CompanionPlantsView(vegetable: vegetable)
                                                }
    
                                                Text("")
                                                    .frame(height: 50)

                                            }
                                            
                                            
                                        }
                                        .padding(.top, 20)
                                    )
                                    .edgesIgnoringSafeArea(.bottom)
                            }
                        }
                    }
                }
                
            }
        }
        .background(Color.themeAccent)
        .navigationBarHidden(true)
    }
}



struct VegetableView_Previews: PreviewProvider {
    static let data = LoadDataModel()
    static var previews: some View {
        let mockRealmManager = RealmManager() // Create an instance of the mock realm manager
//        mockRealmManager.createUserLocationIfNeeded(zipcode: "73301")
//        mockRealmManager.updateUserLocationWithDates(zipcode: "10001")
        return NavigationView {
            // Pass the mock realm manager to the environment
            VegetableView(vegetable: data.vegetables[2])
                .environmentObject(mockRealmManager)
        }
    }
}




enum CurrentVegetableHeaderView: String, Equatable {
    case sowingAndPlanting = "Sowing and Planting"
    case careAndMaintenance = "Care and Maintenance"
    case harvestAndStorage = "Harvest and Storage"
    case pests = "Pests"
    case disease = "Diseases"
    case companions = "Companion Planting"
}
