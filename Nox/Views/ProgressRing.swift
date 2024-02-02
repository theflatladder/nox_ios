//
//  ProgressRing.swift
//  Nox
//
//  Created by Александр Новиков on 18.01.2024.
//

import SwiftUI

struct ProgressRing: View {
    
    var habit: Habit?
    var size: CGFloat
    var tapActive = false
    var emoji = false
    var lineWidth: CGFloat {
        size * 0.15
    }
    
    var body: some View {
        ZStack{
            Circle()
                .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .foregroundColor(Color(UIColor.systemGray5))
            Circle()
                .trim(from: 0, to: min(1, CGFloat(habit?.currentCount ?? 0) / CGFloat(habit?.maxCount ?? 1)))
                .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .foregroundColor(Color.additional)
                .rotationEffect(.degrees(270))
                .animation(.easeOut, value: habit?.currentCount ?? 0)
            
            Button(intent: HabitTapIntent(habitId: habit?.id), label: {
                Text(emoji ? (habit?.emoji ?? "") : (habit?.currentCount.toString() ?? ""))
                    .foregroundColor(habit == nil || habit!.currentCount == 0 ? .systemGray2 : .primary)
                    .font(.RubikRegular(emoji ? size * 0.33 : size * 0.5))
                    .frame(width: size - lineWidth, height: size - lineWidth)
                    .contentShape(Circle())
                    .cornerRadius(size/2)
            })
            .buttonStyle(.plain)
            .opacity(tapActive ? 1 : 0)
        }
        .frame(width: size, height: size)
    }
}

extension Int{
    func toString() -> String{
        String(self)
    }
}

#Preview {
    ProgressRing(habit: .testHabit, size: 100, tapActive: true)
}
