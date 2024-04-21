//
//  realmManagerSquareFootBed.swift
//  VeggieVerse
//
//  Created by Ryan Weber on 3/22/24.
//


import Foundation
import RealmSwift

extension RealmManager {
    func addNewPlantToSquare(id: ObjectId, plant: Vegetable) {
        if let localRealm = localRealm {
            do {
                if let square = localRealm.objects(Square.self).filter(NSPredicate(format: "id == %@", id)).first {
                    try localRealm.write {
                        if let vegetable = LoadDataModel.shared.vegetables.first(where: { $0.id == plant.id } ) {
                            square.plant = Plant(plant: vegetable)
                        }
                    }
                }
            } catch {
                print("Error updating square \(id) to Realm: \(error)")
            }
        }
    }
    func swapPlants(bedID: ObjectId, index1: Int, index2: Int) {
        if let localRealm = localRealm {
            do {
                if let bed = localRealm.object(ofType: SquareFootBed.self, forPrimaryKey: bedID) {
                    if let square1 = bed.squares.first(where: { $0.index == index1 }),
                       let square2 = bed.squares.first(where: { $0.index == index2 }) {
                        let plant1 = square1.plant
                        let plant2 = square2.plant
                        try localRealm.write {
                            square1.plant = plant2
                            square2.plant = plant1
                        }
                    }
                }
            } catch {
                print("Error swapping plants in bed \(bedID): \(error)")
            }
        }
    }
    func toggleSquareLockState(id: ObjectId) {
        if let localRealm = localRealm {
            do {
                if let square = localRealm.objects(Square.self).filter(NSPredicate(format: "id == %@", id)).first {
                    try localRealm.write {
                        square.locked.toggle()
                    }
                }
            } catch {
                print("Error updating square \(id) to Realm: \(error)")
            }
        }
    }
    func randomlyAssignPlants(bedID: ObjectId) {
        if let localRealm = localRealm {
            do {
                if let bed = localRealm.objects(SquareFootBed.self).filter(NSPredicate(format: "id == %@", bedID)).first {
                    let unlockedSquares = bed.squares.filter { !$0.locked }
                    var unlockedPlants = [Plant]()
                    for square in unlockedSquares {
                        if let plant = square.plant {
                            unlockedPlants.append(plant)
                        }
                    }
                    let shuffledPlants = unlockedPlants.shuffled()
                    var plantIndex = 0
                    try localRealm.write {
                        for sq in unlockedSquares.shuffled() {
                            if let square = localRealm.objects(Square.self).filter(NSPredicate(format: "id == %@", sq.id)).first {
                                if plantIndex < shuffledPlants.count {
                                    square.plant = shuffledPlants[plantIndex]
                                    plantIndex += 1
                                } else {
                                    square.plant = nil
                                }
                            }
                        }
                    }
                }
            } catch {
                print("Error updating square \(bedID) to Realm: \(error)")
            }
        }
    }

    
    func UpdateBedLayout(bedID: ObjectId, localSquares: [LocalSquare]) {
        if let localRealm = localRealm {
            do {
                if let bed = localRealm.objects(SquareFootBed.self).filter(NSPredicate(format: "id == %@", bedID)).first {
                    try localRealm.write {
                        for square in bed.squares {
                            for localSquare in localSquares {
                                if square.x == localSquare.x && square.y == localSquare.y {
                                    if localSquare.plant != nil {
                                        if let plant = localRealm.objects(Plant.self).filter(NSPredicate(format: "id == %@", localSquare.plant!.id)).first {
                                            square.plant = plant
                                        } else {
                                            square.plant = nil
                                        }
                                    } else {
                                        square.plant = nil
                                    }
                                }
                            }
                        }
                    }
                }
            } catch {
                print("Error updating square \(bedID) to Realm: \(error)")
            }
        }
    }
    
}
