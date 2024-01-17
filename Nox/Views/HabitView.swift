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
                .font(.RubikRegular(24))
                .padding(8)
            Spacer()
        }
        .padding(16)
        .background(.background)
        .cornerRadius(16)
    }
}

#Preview {
    HabitView(habit: .testHabit)
}
