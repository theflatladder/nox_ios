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
    var maxCount: Int
    var currentCount: Int
    
    init(title: String, maxCount: Int, currentCount: Int) {
        self.id = UUID().uuidString
        self.title = title
        self.maxCount = maxCount
        self.currentCount = currentCount
    }
    
    static var testHabit: Habit{
        Habit(title: "Test", maxCount: 10, currentCount: .random(in: 1..<10))
    }
}
