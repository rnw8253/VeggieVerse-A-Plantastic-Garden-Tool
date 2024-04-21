//
//  Square.swift
//  VeggieVerse
//
//  Created by Ryan Weber on 4/15/24.
//

import Foundation
import SwiftUI
import RealmSwift
import UniformTypeIdentifiers

class Square: Object, ObjectKeyIdentifiable, Codable, Transferable {
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var locked: Bool
    @Persisted var index: Int
    @Persisted var x: Int
    @Persisted var y: Int
    @Persisted var plant: Plant?
    @Persisted(originProperty: "squares") var square: LinkingObjects<SquareFootBed>
    
    enum CodingKeys: CodingKey {
        case id
        case locked
        case index
        case x
        case y
        case plant
    }

    convenience init(index: Int, x: Int, y: Int, plant: Plant? = nil) {
        self.init()
        self.index = index
        self.x = x
        self.y = y
        self.plant = plant
    }
    
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .squareTask)
    }
}

extension UTType {
    static let squareTask = UTType(exportedAs: "ryweb.VeggieVerse.squareTask")
}

struct LocalSquare {
    var index: Int
    var locked: Bool
    var x: Int
    var y: Int
    var plant: Plant?
}
