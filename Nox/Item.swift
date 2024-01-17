//
//  Item.swift
//  Nox
//
//  Created by Александр Новиков on 17.01.2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
