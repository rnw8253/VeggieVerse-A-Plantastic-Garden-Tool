//
//  CustomPickerView.swift
//  VeggieVerse
//
//  Created by Ryan Weber on 3/1/24.
//

//import SwiftUI
//import RealmSwift
//
//struct VarietyPickerView: View {
//    @EnvironmentObject var appState: AppState
//    @Environment(\.dismiss) var dismiss
//    @Environment(\.colorScheme) var colorScheme
//    @Binding var selectedVariety: Variety?
//    var varieties: [Variety]
//    @State private var filterString: String = ""
//    @State private var frameHeight: CGFloat = 400
//    var filteredVarieties: [Variety] {
//        
//        if filterString == "" {
//            return varieties.sorted(by: { $0.name < $1.name })
//        } else {
//            
//            return varieties.filter({$0.name.lowercased().contains(filterString.lowercased())}).sorted(by: { $0.name < $1.name })
//        }
//    }
//    var body: some View {
//        VStack(alignment: .leading, spacing: 5) {
//            List {
//                ForEach(filteredVarieties, id: \.self) { variety in
//                    Button {
//                        selectedVariety = variety
//                        dismiss()
//                    } label: {
//                        Text(variety.name)
//                            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
//                    }
//                }
//            }
//            .searchable(text: $filterString, placement: .navigationBarDrawer(displayMode: .always) )
//        }
//
//        .navigationBarTitle("Select a Variety")
//        .navigationBarTitleDisplayMode(.inline)
//    }
//}
//
//struct VarietyPickerView_Previews: PreviewProvider {
//    static let sampleData = Array(LoadDataModel().vegetables[0].varieties)
//    @State static var selectedVariety: Variety? = sampleData[0]
//    static var previews: some View {
//        VarietyPickerView(selectedVariety: $selectedVariety, varieties: sampleData)
//    }
//}
