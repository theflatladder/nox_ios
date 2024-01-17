//
//  HabitView.swift
//  Nox
//
//  Created by Александр Новиков on 17.01.2024.
//

import SwiftUI

struct HabitView: View {
    
    @State var habit: Habit
    
    var body: some View {
        HStack{
            ProgressRing(habit: habit, size: 32)
            Text(habit.title)
                .font(Font.custom("Rubik-Regular", size: 18))
        }
    }
}

#Preview {
    HabitView(habit: .testHabit)
}

extension Font{
    
}
