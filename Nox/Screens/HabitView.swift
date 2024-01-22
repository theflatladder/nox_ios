//
//  HabitView.swift
//  Nox
//
//  Created by Александр Новиков on 22.01.2024.
//

import SwiftUI

struct HabitView: View {
    
    @Bindable var habit: Habit
    
    var body: some View {
        VStack(spacing: 32){
            Text(habit.title)
                .font(.RubikRegular(24))
            ZStack{
                ProgressRing(habit: habit, size: 200)
                VStack{
                    Text("\(habit.currentCount) left")
                        .font(.RubikRegular(24))
                    Text("Will refresh next \(habit.period.title)")
                        .font(.RubikRegular(14))
                        .foregroundColor(Color.systemGray)
                }
            }
            Spacer()
        }
        .padding(.top, 48)
    }
}

#Preview {
    var newHabit = Habit.testHabit
    return HabitView(habit: newHabit)
}
