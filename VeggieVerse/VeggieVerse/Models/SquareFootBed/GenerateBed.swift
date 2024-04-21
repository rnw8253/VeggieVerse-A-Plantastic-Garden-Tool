//
//  GenerateBed.swift
//  VeggieVerse
//
//  Created by Ryan Weber on 3/27/24.
//

import Foundation

func GenerateBed() -> SquareFootBed {
    let data = LoadDataModel()
    let newBed = SquareFootBed(length: 8, width: 4)

    newBed.addPlant(plant: data.vegetables[98])
    newBed.addPlant(plant: data.vegetables[98])
    newBed.addPlant(plant: data.vegetables[105])
    newBed.addPlant(plant: data.vegetables[105])
    newBed.addPlant(plant: data.vegetables[81])
    newBed.addPlant(plant: data.vegetables[81])
    newBed.addPlant(plant: data.vegetables[81])
    newBed.addPlant(plant: data.vegetables[81])
    newBed.addPlant(plant: data.vegetables[14])
    newBed.addPlant(plant: data.vegetables[14])
    newBed.addPlant(plant: data.vegetables[14])
    newBed.addPlant(plant: data.vegetables[30])
    newBed.addPlant(plant: data.vegetables[30])
    newBed.addPlant(plant: data.vegetables[30])
    newBed.addPlant(plant: data.vegetables[28])
    newBed.addPlant(plant: data.vegetables[28])
    newBed.addPlant(plant: data.vegetables[28])
    newBed.addPlant(plant: data.vegetables[97])
    newBed.addPlant(plant: data.vegetables[97])
    newBed.addPlant(plant: data.vegetables[97])
    newBed.addPlant(plant: data.vegetables[97])
    newBed.addPlant(plant: data.vegetables[118])
    newBed.addPlant(plant: data.vegetables[104])
    newBed.addPlant(plant: data.vegetables[73])
    newBed.addPlant(plant: data.vegetables[4])
    newBed.addPlant(plant: data.vegetables[4])
    newBed.addPlant(plant: data.vegetables[0])
    newBed.addPlant(plant: data.vegetables[8])
    newBed.addPlant(plant: data.vegetables[43])
    newBed.addPlant(plant: data.vegetables[79])
    newBed.addPlant(plant: data.vegetables[129])
    return newBed
}
