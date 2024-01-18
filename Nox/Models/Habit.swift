//
//  Item.swift
//  Nox
//
//  Created by Александр Новиков on 17.01.2024.
//

import Foundation
import SwiftData

@Model
class Habit: Identifiable {
    
    var id: String
    var title: String
    var period: Period
    var maxCount: Int
    var currentCount: Int
    
    init(title: String, period: Period, maxCount: Int, currentCount: Int) {
        self.id = UUID().uuidString
        self.title = title
        self.period = period
        self.maxCount = maxCount
        self.currentCount = currentCount
    }
    
    static var testHabit: Habit{
        Habit(title: "Test", period: .Weekly, maxCount: 10, currentCount: .random(in: 1..<10))
    }
}

enum Period: Codable{
    
    case Dayly, Weekly, Monthly, Yearly
    
    var title: String{
        switch self {
        case .Dayly:
            return "D"
        case .Weekly:
            return "W"
        case .Monthly:
            return "M"
        case .Yearly:
            return "Y"
        }
    }
    
}
