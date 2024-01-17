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
    
    init(title: String) {
        self.id = UUID().uuidString
        self.title = title
    }
    
}
