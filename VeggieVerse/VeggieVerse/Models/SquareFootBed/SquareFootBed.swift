//
//  SquareFootBed.swift
//  VeggieVerse
//
//  Created by Ryan Weber on 3/19/24.
//

import Foundation
import SwiftUI
import RealmSwift



class SquareFootBed: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String = "BED"
    @Persisted var length: Int = 0
    @Persisted var width: Int = 0
    @Persisted var squares = RealmSwift.List<Square>()
    @Persisted var plants = RealmSwift.List<Plant>()
    
    var maxDistance: Double {
        return sqrt(Double(length*length) + Double(width*width))
    }
    var companionshipTable: [String: CompanionType] = [:]
    
    lazy var distanceMatrix: [[Double]] = {
        var matrix = [[Double]](repeating: [Double](repeating: 0.0, count: squares.count), count: squares.count)
        for i in 0..<squares.count {
            for j in 0..<squares.count {
                let dx = Double(squares[i].x - squares[j].x)
                let dy = Double(squares[i].y - squares[j].y)
                matrix[i][j] = sqrt(dx*dx + dy*dy)
            }
        }
        return matrix
    }()
    convenience init(length: Int, width: Int) {
        self.init()
        self.length = length
        self.width = width
        
        for index in 0..<(length * width) {
            let x = index / width
            let y = index % width
            let square = Square(index: index, x: x, y: y)
            self.squares.append(square)
        }
    }
    func printPlantsInSquares() {
        for index in 0..<(length * width) {
            for square in squares {
                if square.index == index {
                    if let plant = square.plant?.plant {
                        print("Plant \(plant.name) is in square (\(square.x), \(square.y))")
                    } else {
                        print("No plant in square (\(square.x), \(square.y))")
                    }
                }
            }
        }
    }
    func addPlant(plant: Vegetable) {
        plants.append(Plant(plant: plant))
    }
    func randomizeBed() {
        var plantIndex = 0
        for square in self.squares {
            if plantIndex < plants.count {
                square.plant = plants[plantIndex]
                plantIndex += 1
            }
        }
    }
    func generateCompanionshipKey(plant1Name: String, plant2Name: String) -> String {
        let sortedNames = [plant1Name, plant2Name].sorted()
        let key = sortedNames.joined(separator: "-")
        return key
    }
    func ComputeCompanionshipTable() {
        var table: [String: CompanionType] = [:]
        for plant1 in plants {
            for plant2 in plants {
                let key = generateCompanionshipKey(plant1Name: plant1.plant.name, plant2Name: plant2.plant.name)
                if table[key] == nil {
                    if plant2.plant.companionPlants!.goodCompanionPlants.contains(where: { $0.name == plant1.plant.name}) || plant1.plant.companionPlants!.goodCompanionPlants.contains(where: { $0.name == plant2.plant.name}) {
                        table[key] = .good
                    } else if plant2.plant.companionPlants!.badCompanionPlants.contains(where: { $0.name == plant1.plant.name}) || plant1.plant.companionPlants!.badCompanionPlants.contains(where: { $0.name == plant2.plant.name}) {
                        table[key] =  .bad
                    } else {
                        for (category, plants) in LoadDataModel.shared.plantCategories {
                            if (plant2.plant.companionPlants!.goodCompanionPlants.contains(where: { $0.name == category }) && plants.contains(plant1.plant.name)) || (plant1.plant.companionPlants!.goodCompanionPlants.contains(where: { $0.name == category }) && plants.contains(plant2.plant.name)) {
                                table[key] =  .good
                            } else if (plant2.plant.companionPlants!.badCompanionPlants.contains(where: { $0.name == category }) && plants.contains(plant1.plant.name)) || (plant1.plant.companionPlants!.badCompanionPlants.contains(where: { $0.name == category }) && plants.contains(plant2.plant.name)) {
                                table[key] =  .bad
                            }
                        }
                        table[key] = .neutral
                    }
                }
            }
        }
        companionshipTable = table
    }
    func CalculatePlantPairScore(s1: LocalSquare, s2: LocalSquare) -> Double {
        if s2.plant != nil && s1.plant != nil {
            let key = generateCompanionshipKey(plant1Name: s1.plant!.plant.name, plant2Name: s2.plant!.plant.name)
            switch companionshipTable[key] {
            case .good:
                return maxDistance - distanceMatrix[s1.index][s2.index] + 1
            case .bad:
                return distanceMatrix[s1.index][s2.index] - 1 - maxDistance
            case .neutral:
                return 0
            default:
                return 0
            }
        } else {
            return 0
        }
    }
    
    func printLocalSquares(localSquares: [LocalSquare]) {
        for index in 0..<(length * width) {
            for sq in localSquares {
                if sq.index == index {
                    if let plant = sq.plant {
                        print("Plant \(plant) is in square (\(sq.x), \(sq.y))")
                    } else {
                        print("No plant in square (\(sq.x), \(sq.y))")
                    }
                }
            }
        }
    }
    func calculateOptimalLayout(isCalculating: Binding<Bool>, initial_temperature: Double, cooling_rate: Double, iterations: Int) {
        isCalculating.wrappedValue = true
        let localSquares: [LocalSquare] = self.squares.map { square in
            LocalSquare(index: square.index, locked: square.locked, x: square.x, y: square.y, plant: square.plant)
        }
        // Dispatch simulated annealing to a background thread
        DispatchQueue.global(qos: .background).async { [self] in
            let optimizedSquares = simulatedAnnealing(local_squares: localSquares, initial_temperature: initial_temperature, cooling_rate: cooling_rate, iterations: iterations)
//            print(optimizedSquares)
            DispatchQueue.main.async {
                RealmManager.shared.UpdateBedLayout(bedID: self.id, localSquares: optimizedSquares)
                isCalculating.wrappedValue = false
            }
        }

    }

    
    func simulatedAnnealing(local_squares: [LocalSquare], initial_temperature: Double, cooling_rate: Double, iterations: Int) -> [LocalSquare] {
        var localSquares = local_squares
        self.printLocalSquares(localSquares: localSquares)
        var currentTemperature = initial_temperature
        while currentTemperature > 0.01 {
            for _ in 0..<iterations {
                // Get random squares
                localSquares.shuffle()
                var s1 = localSquares[0]
                var s2 = localSquares[1]
                if !s1.locked && !s2.locked {
                    // Calculate swap score
                    var originalScore = 0.0
                    var newScore = 0.0
                    
                    // Calculate original score
                    for square in localSquares {
                        originalScore += CalculatePlantPairScore(s1: s1, s2: square)
                        originalScore += CalculatePlantPairScore(s1: s2, s2: square)
                    }
                    
                    // Calculate new score without physically swapping
                    let s1Plant = s1.plant
                    let s2Plant = s2.plant
                    s1.plant = s2Plant
                    s2.plant = s1Plant
                    
                    for square in localSquares {
                        newScore += CalculatePlantPairScore(s1: s1, s2: square)
                        newScore += CalculatePlantPairScore(s1: s2, s2: square)
                    }
                    
                    // Restore original state
                    s1.plant = s1Plant
                    s2.plant = s2Plant
                    
                    let swapScore = newScore - originalScore
                    
                    // Perform swap with a certain probability based on swap score and temperature
                    if swapScore > 0 || Double.random(in: 0.0..<1.0) < exp(swapScore / currentTemperature) {
                        let tempPlant = s1.plant
                        localSquares[0].plant = s2.plant
                        localSquares[1].plant = tempPlant
                    }
                }
            }
            currentTemperature *= cooling_rate
        }
        self.printLocalSquares(localSquares: localSquares)
        return localSquares
    }
    
    func unassignedPlantCounts() -> [String : Int] {
        var unassignedCounts: [String : Int]  = [:]
        
        for plant in plants {
            if let count = unassignedCounts[plant.plant.name] {
                unassignedCounts[plant.plant.name] = count + 1
            } else {
                unassignedCounts[plant.plant.name] = 1
            }
        }
        
        for square in squares {
            if square.plant != nil {
                if let count = unassignedCounts[square.plant!.plant.name] {
                    unassignedCounts[square.plant!.plant.name] = count - 1
                }
            }
        }
        
        unassignedCounts = unassignedCounts.filter { $0.value > 0 }
        
        return unassignedCounts
    }
}


enum CompanionType {
    case good
    case bad
    case neutral
}
