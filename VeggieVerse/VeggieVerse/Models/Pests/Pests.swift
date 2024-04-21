//
//  Pests.swift
//  VeggieVerse
//
//  Created by Ryan Weber on 3/14/24.
//

import Foundation
import RealmSwift

class Pest: Object, Codable, Identifiable {
    @Persisted var name: String
    @Persisted var descriptionText: String
    @Persisted var attracts: String
    @Persisted var repels: String
    @Persisted var prevention: String
    @Persisted var removal: String

    
    enum CodingKeys: String, CodingKey {
        case name
        case descriptionText = "description"
        case attracts
        case repels
        case prevention
        case removal
    }
}
