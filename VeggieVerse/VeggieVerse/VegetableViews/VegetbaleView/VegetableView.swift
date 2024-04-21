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
    @State private var currentHeader = CurrentVegetableHeaderView.sowingAndPlanting
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                VegetableNavBarView(title: vegetable.name, titleColor: .white, shadowColor: .black, openColor: .white, height: 130, curveVal: curveVal, backgroundImage: vegetable.backgroundImageUrl)
                    .frame(height: 40)
                VStack {
                    ZStack {
                        VStack {
                            Image("seeds2")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 30)
                            Spacer()
                        }
                        VStack(spacing: 0) {
                            ZStack {
                                CurveSidedRectangle(curveHeightTop: curveVal, curveHeightBottom: curveVal)
                                    .fill(Color.themeBackground)
                                    .shadow(color: .gray, radius: 20)
                                    .frame(height: 60)
                            }
                            ZStack {
                                CurveSidedRectangle(curveHeightTop: curveVal, curveHeightBottom: 0)
                                    .fill(Color.themeBackground)
                                    .shadow(radius: 30)
                                    .overlay(
                                        ScrollView {
                                            VStack {
                                                VegetableSectionHeaderView(currentHeader: $currentHeader, curveVal: curveVal, fillColor: Color.gradColor2)
                                                switch currentHeader {
                                                case .general:
                                                    GeneralView(vegetable: vegetable)
                                                case .sowingAndPlanting:
                                                    SowingAndPlantingView(vegetable: vegetable)
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
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.themeAccent)
                    .overlay(
                        HStack {
                            Spacer()
                            ForEach(CurrentVegetableHeaderView.allCases, id: \.self) { val in
                                Button {
                                    withAnimation(.easeIn(duration: 0.1)) {
                                        currentHeader = val
                                    }
                                } label: {
                                    VStack {
                                        if currentHeader == val {
                                            Image(val.image)
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 60, height: 60)
                                        } else {
                                            Image(val.image)
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 40, height: 40)
                                        }
                                    }
                                    .padding(.top)
                                }
                                Spacer()
                            }
   
                        }
                    )
                    .frame(height: 50)
            }
        }
        .background(Color.themeAccent)
//        .navigationBarHidden(true)
    }
}



struct VegetableView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            VegetableView(vegetable: LoadDataModel.shared.vegetables[46])
        }
    }
}




enum CurrentVegetableHeaderView: String, Equatable, CaseIterable {
    case general = "General"
    case sowingAndPlanting = "Sowing and Planting"
    case careAndMaintenance = "Care and Maintenance"
    case harvestAndStorage = "Harvest and Storage"
    case pests = "Pests"
    case disease = "Diseases"
    case companions = "Companion Planting"
}

extension CurrentVegetableHeaderView {
    var label: String {
        switch self {
        case .general:
            return "General"
        case .sowingAndPlanting:
            return "Sow"
        case .careAndMaintenance:
            return "Care"
        case .harvestAndStorage:
            return "Harvest"
        case .pests:
            return "Pest"
        case .disease:
            return "Disease"
        case .companions:
            return "Companion"
        }
    }
    
    var image: String {
        switch self {
        case .general:
            return "general"
        case .sowingAndPlanting:
            return "seedSpacing"
        case .careAndMaintenance:
            return "pruning"
        case .harvestAndStorage:
            return "harvest"
        case .pests:
            return "pest"
        case .disease:
            return "disease"
        case .companions:
            return "goodCompanion"
        }
    }
}
