//
//  Diseases.swift
//  VeggieVerse
//
//  Created by Ryan Weber on 3/14/24.
//

import Foundation
import RealmSwift

class Disease: Object, Codable, Identifiable {
    @Persisted var name: String
    @Persisted var descriptionText: String
    @Persisted var causes: String
    @Persisted var prevention: String
    @Persisted var removal: String

    
    enum CodingKeys: String, CodingKey {
        case name
        case descriptionText = "description"
        case causes
        case prevention
        case removal
    }
}
