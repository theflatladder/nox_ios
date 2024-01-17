//
//  ProgressRing.swift
//  Nox
//
//  Created by Александр Новиков on 18.01.2024.
//

import SwiftUI

struct ProgressRing: View {
    
    @State var habit: Habit
    var size: CGFloat
    var lineWidth: CGFloat {
        size * 0.12
    }
    
    var body: some View {
        ZStack{
            Circle()
                .stroke(lineWidth: lineWidth)
                .foregroundColor(Color(UIColor.systemGray5))
            Circle()
                .trim(from: 0, to: min(1, CGFloat(habit.currentCount) / CGFloat(habit.maxCount)))
                .stroke(lineWidth: lineWidth)
                .foregroundColor(.additional)
                .rotationEffect(.degrees(270))
                .animation(.easeOut, value: habit.currentCount)
        }
        .frame(width: size, height: size)
    }
}

#Preview {
    ProgressRing(habit: .testHabit, size: 100)
}
