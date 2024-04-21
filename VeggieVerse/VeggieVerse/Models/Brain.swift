//
//  Brain.swift
//  VeggieVerse
//
//  Created by Ryan Weber on 3/31/24.
//

import Foundation



func CalculateSpringSowDateString(vegetable: Vegetable) -> (String, String, String, String, String, String, String, String) {
    let frostDates = lookupFrostDates(for: "64068")
    let date = Date()
    let calendar = Calendar.current
    let year = calendar.component(.year, from: date)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "YY, MMM d"
    var springIndoor = "-"
    var springTransplant = "-"
    var springOutdoor = "-"
    var lastSowDate = "-"
    var fallTransplant = "-"
    var fallOutdoor = "-"
    var daysToMaturity = "-"
    var frostTolerance = "-"
    if let date = dateFormatter.date(from: "\(year), \(frostDates!.lastSpringFrost)") {
        if vegetable.springSowing!.indoors.count > 0 {
            let first = Calendar.current.date(byAdding: .weekOfYear, value: vegetable.springSowing!.indoors[0], to: date)!
            let second = Calendar.current.date(byAdding: .weekOfYear, value: vegetable.springSowing!.indoors[1], to: date)!
            springIndoor = "\(first.formatted(Date.FormatStyle().month())) \(first.formatted(Date.FormatStyle().day())) - \(second.formatted(Date.FormatStyle().month())) \(second.formatted(Date.FormatStyle().day()))"
        }
        if vegetable.springSowing!.transplant.count > 0 {
            let first = Calendar.current.date(byAdding: .weekOfYear, value: vegetable.springSowing!.transplant[0], to: date)!
            let second = Calendar.current.date(byAdding: .weekOfYear, value: vegetable.springSowing!.transplant[1], to: date)!
            springTransplant = "\(first.formatted(Date.FormatStyle().month())) \(first.formatted(Date.FormatStyle().day())) - \(second.formatted(Date.FormatStyle().month())) \(second.formatted(Date.FormatStyle().day()))"
        }
        if vegetable.springSowing!.outdoors.count > 0 {
            let first = Calendar.current.date(byAdding: .weekOfYear, value: vegetable.springSowing!.outdoors[0], to: date)!
            let second = Calendar.current.date(byAdding: .weekOfYear, value: vegetable.springSowing!.outdoors[1], to: date)!
            springOutdoor = "\(first.formatted(Date.FormatStyle().month())) \(first.formatted(Date.FormatStyle().day())) - \(second.formatted(Date.FormatStyle().month())) \(second.formatted(Date.FormatStyle().day()))"
        }
    }
    if let date = dateFormatter.date(from: "\(year), \(frostDates!.firstFallFrost)") {
        if vegetable.springSowing!.lastSowDate != nil {
            let temp = Calendar.current.date(byAdding: .weekOfYear, value: vegetable.springSowing!.lastSowDate!, to: date)!
            lastSowDate = "\(temp.formatted(Date.FormatStyle().month())) \(temp.formatted(Date.FormatStyle().day()))"
        }
        if vegetable.fallSowing!.transplant.count > 0 {
            let first = Calendar.current.date(byAdding: .weekOfYear, value: vegetable.fallSowing!.transplant[0], to: date)!
            let second = Calendar.current.date(byAdding: .weekOfYear, value: vegetable.fallSowing!.transplant[1], to: date)!
            fallTransplant = "\(first.formatted(Date.FormatStyle().month())) \(first.formatted(Date.FormatStyle().day())) - \(second.formatted(Date.FormatStyle().month())) \(second.formatted(Date.FormatStyle().day()))"
        }
        if vegetable.fallSowing!.outdoors.count > 0 {
            let first = Calendar.current.date(byAdding: .weekOfYear, value: vegetable.fallSowing!.outdoors[0], to: date)!
            let second = Calendar.current.date(byAdding: .weekOfYear, value: vegetable.fallSowing!.outdoors[1], to: date)!
            fallOutdoor = "\(first.formatted(Date.FormatStyle().month())) \(first.formatted(Date.FormatStyle().day())) - \(second.formatted(Date.FormatStyle().month())) \(second.formatted(Date.FormatStyle().day()))"
        }
    }
    daysToMaturity = String(vegetable.fallSowing!.daysToMaturity)
    frostTolerance = vegetable.fallSowing!.frostTolerance
    
    return (springIndoor, springTransplant, springOutdoor, lastSowDate, fallTransplant, fallOutdoor, daysToMaturity, frostTolerance)
}

