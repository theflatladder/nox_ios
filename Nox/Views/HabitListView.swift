//
//  HabitView.swift
//  Nox
//
//  Created by Александр Новиков on 17.01.2024.
//

import SwiftUI

struct HabitListView: View {
    
    @Bindable var habit: Habit
    
    @State private var plusOpacity = 1.0
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
            Button(action: {
                habit.currentCount -= 1
            }, label: {
                Image(systemName: "plus")
                    .foregroundColor(.primary)
                    .frame(width: 32, height: 32)
                    .background(Color.systemGray6)
                    .cornerRadius(8)
            })
            .opacity(plusOpacity)
            .onChange(of: habit.currentCount, {
                withAnimation{
                    plusOpacity = habit.currentCount == 0 ? 0 : 1
                    titleColor = habit.currentCount == 0 ? .systemGray : .primary
                }
            })
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
