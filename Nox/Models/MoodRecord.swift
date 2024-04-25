//
//  MoodRecord.swift
//  Nox
//
//  Created by Александр Новиков on 25.04.2024.
//

import SwiftUI
import SwiftData

@Model
class MoodRecord: Identifiable {
    
    var id: String
    var date: Date
    var value: MoodValue
    var color: Color { value.color }
    
    init(date: Date, value: MoodValue) {
        self.id = UUID().uuidString
        self.date = date
        self.value = value
    }

    static var testMoodRecord: MoodRecord{
        MoodRecord(date: Date(), value: .Good)
    }
}

enum MoodValue: Int, Codable, CaseIterable, Identifiable{
    
    var id: MoodValue { self }
    
    case Bad = 0
    case Mid = 1
    case Good = 2
    
    var title: String{
        switch self {
        case .Good:
            return "Good"
        case .Mid:
            return "Mediocre"
        case .Bad:
            return "Bad"
        }
    }
    
    var color: Color{
        switch self {
        case .Good:
            return .green
        case .Mid:
            return .yellow
        case .Bad:
            return .red
        }
    }
    
}
