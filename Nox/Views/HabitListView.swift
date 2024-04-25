//
//  HabitView.swift
//  Nox
//
//  Created by Александр Новиков on 17.01.2024.
//

import SwiftUI

struct HabitListView: View {
    
    @Bindable var habit: Habit
    @State private var titleColor = Color.primary
    
    var body: some View {
        HStack{
            ProgressRing(habit: habit, size: 24)
            Text(habit.title)
                .lineLimit(1)
                .font(.RubikRegular(18))
                .padding(4)
                .foregroundColor(titleColor)
            Spacer()
            
            Text("\(habit.currentCount)")
                .lineLimit(1)
                .font(.RubikRegular(18))
                .padding(4)
                .foregroundColor(titleColor)
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 16)
        .background(.background)
        .cornerRadius(16)
    }
}

#Preview {
    HabitListView(habit: .testHabit)
}
