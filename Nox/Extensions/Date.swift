//
//  Date.swift
//  Nox
//
//  Created by Александр Новиков on 25.04.2024.
//

import Foundation

extension Date{
    
    static var today: Date {
        let now = Date()
        var dateComponents = DateComponents()
        dateComponents.day = Calendar.current.component(.day, from: now)
        dateComponents.month = Calendar.current.component(.month, from: now)
        dateComponents.year = Calendar.current.component(.year, from: now)
        dateComponents.timeZone = TimeZone(abbreviation: "UTC")
        return Calendar.current.date(from: dateComponents)!
    }
    
    var firstDayOfMonth: Date{
        var dateComponents = DateComponents()
        dateComponents.day = 1
        dateComponents.month = Calendar.current.component(.month, from: self)
        dateComponents.year = Calendar.current.component(.year, from: self)
        dateComponents.timeZone = TimeZone(abbreviation: "UTC")
        return Calendar.current.date(from: dateComponents)!
    }
    
    var year: Int{
        Calendar.current.component(.year, from: self)
    }
    
}
