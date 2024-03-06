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
    @State var selectedVariety: Variety? = nil
    @EnvironmentObject var realmManager: RealmManager
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
                            CurveSidedRectangle(curveHeightTop: curveVal, curveHeightBottom: curveVal)
                                .fill(Color.themeBackground)
                                .shadow(color: .gray, radius: 20)
                                .frame(height: 60)
                            
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
                                                NavigationLink(destination: VarietyPickerView(selectedVariety: $selectedVariety, varieties: Array(vegetable.varieties))) {
                                                    CurveSidedRectangle(curveHeightTop: curveVal-10, curveHeightBottom: curveVal-15)
                                                        .fill(Color.themeTertiary)
                                                        .frame(height: 60)
                                                        .padding(.horizontal,40)
                                                        .padding(.vertical, 5)
                                                        .overlay(
                                                            VStack {
                                                                Text(selectedVariety?.name ?? "Unselected")
                                                                    .font(Font.custom("AmericanTypewriter", size: 25))
                                                                    .padding(.top, 30)
                                                                    .foregroundColor(.black)
                                                                Text("Variety")
                                                                    .font(Font.custom("AmericanTypewriter", size: 15))
                                                                    .foregroundColor(.black)
                                                            }
                                                        )
                                                }
                                                VegetableSectionHeaderView(text: "Sowing and Planting", curveVal: curveVal, fillColor: Color.gradColor2)
                                                SowingAndPlantingView(vegetable: vegetable, selectedVariety: $selectedVariety, userLocation: realmManager.loadUserLocation())
                                                VegetableSectionHeaderView(text: "Care and Maintenance", curveVal: curveVal, fillColor: Color.gradColor2)
                                                CareAndMaintenanceView(vegetable: vegetable, selectedVariety: $selectedVariety)
                                                VegetableSectionHeaderView(text: "Harvesting and Storage", curveVal: curveVal, fillColor: Color.gradColor2)
                                                HarvestingAndStorageView(vegetable: vegetable)
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
            VegetableView(vegetable: data.vegetables[0])
                .environmentObject(mockRealmManager)
        }
    }
}




