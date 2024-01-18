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
    
    init(title: String = "", period: Period = .Weekly, maxCount: Int = 10, currentCount: Int = 10) {
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

enum Period: Int, Codable, CaseIterable, Identifiable{
    
    var id: Self { self }
    
    case Dayly = 0
    case Weekly = 1
    case Monthly = 2
    case Yearly = 3
    
    var title: String{
        switch self {
        case .Dayly:
            return "Day"
        case .Weekly:
            return "Week"
        case .Monthly:
            return "Month"
        case .Yearly:
            return "Year"
        }
    }
    
}
