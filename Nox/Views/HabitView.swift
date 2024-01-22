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
            ProgressRing(habit: habit, size: 24)
            Text(habit.title)
                .lineLimit(1)
                .font(.RubikRegular(18))
                .padding(4)
            Spacer()
            Text(habit.period.title.first!.uppercased())
                .font(.RubikRegular(18))
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 16)
        .background(.background)
        .cornerRadius(16)
    }
}

#Preview {
    HabitView(habit: .testHabit)
}
