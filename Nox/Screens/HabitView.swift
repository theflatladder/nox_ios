//
//  HabitView.swift
//  Nox
//
//  Created by Александр Новиков on 22.01.2024.
//

import SwiftUI
import WidgetKit

struct HabitView: View {
    
    @Bindable var habit: Habit
    @State private var plusOpacity = 1.0
    
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
            Button(action: {
                habit.currentCount -= 1
                WidgetCenter.shared.reloadAllTimelines()
            }, label: {
                Image(systemName: "plus")
                    .foregroundColor(.primary)
                    .frame(width: 48, height: 48)
                    .background(Color.systemGray6)
                    .cornerRadius(8)
            })
            .opacity(plusOpacity)
            .padding(.top, 32)
            Spacer()
        }
        .padding(.top, 48)
        .onChange(of: habit.currentCount, {
            withAnimation{
                plusOpacity = habit.currentCount == 0 ? 0 : 1
            }
        })
    }
}

#Preview {
    var newHabit = Habit.testHabit
    return HabitView(habit: newHabit)
}
