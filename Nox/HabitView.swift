//
//  HabitView.swift
//  Nox
//
//  Created by Александр Новиков on 17.01.2024.
//

import SwiftUI

struct HabitView: View {
    
    var habit: Habit
    
    var body: some View {
        HStack{
            Image(systemName: "globe")
            Text(habit.title)
        }
    }
}

#Preview {
    HabitView(habit: Habit(title: "Test"))
}
