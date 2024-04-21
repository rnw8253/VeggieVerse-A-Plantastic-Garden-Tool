//
//  GardenBedView.swift
//  VeggieVerse
//
//  Created by Ryan Weber on 3/21/24.
//

import SwiftUI
import RealmSwift

struct GardenBedView: View {
    @ObservedRealmObject var bed: SquareFootBed
    @State var currentView: CurrentGardenBedView = .bedGrid
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            switch currentView {
            case .bedGrid:
                GardenBedLayoutView(bed: bed)
            case .toDoList:
                GardenBedToDoListView()
            
            }
            Spacer()
            RoundedRectangle(cornerRadius: 0)
                .fill(Color.themeAccent)
                .overlay(
                    HStack {
                        Spacer()
                        ForEach(CurrentGardenBedView.allCases, id: \.self) { val in
                            Button {
                                withAnimation(.easeIn(duration: 0.1)) {
                                    currentView = val
                                }
                            } label: {
                                VStack {
                                    if currentView == val {
                                        VStack(spacing: 0) {
                                            Image(val.image)
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 60, height: 60)
//                                            Text(val.label)
//                                                .font(.caption)
//                                                .foregroundColor(.black)
                                        }
                                        
                                    } else {
                                        Image(val.image)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 40, height: 40)
//                                        Text(val.label)
//                                            .font(.caption)
//                                            .foregroundColor(.black)
                                    }
                                }
                                .padding(.vertical)
                            }
                            Spacer()
                        }
                    }
                )
                .frame(height: 80)
                .edgesIgnoringSafeArea(.bottom)
 
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color.themeBackground)
    }
}

enum CurrentGardenBedView: String, Equatable, CaseIterable {
    case bedGrid = "Layout"
    case toDoList = "To-Do List"
    
}

extension CurrentGardenBedView {
    var label: String {
        switch self {
        case .bedGrid:
            return "Layout"
        case .toDoList:
            return "todoList"
        }
    }
    
    var image: String {
        switch self {
        case .bedGrid:
            return "layout"
        case .toDoList:
            return "layout"
        }
    }
}

struct GardenBedView_Previews: PreviewProvider {
    static var previews: some View {
        GardenBedView(bed: RealmManager.shared.localRealm?.objects(SquareFootBed.self).first ?? GenerateBed())
    }
}
