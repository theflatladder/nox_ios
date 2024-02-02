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
    @State private var showReturn = true
    @State private var showPlus = true
    
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
            HStack(spacing: 16){
                if showReturn {
                    Button(action: {
                        habit.currentCount += 1
                        WidgetCenter.shared.reloadTimelines(ofKind: "WidgetExtension")
                    }, label: {
                        Image(systemName: "arrow.counterclockwise")
                            .foregroundColor(.primary)
                            .frame(width: 48, height: 48)
                            .background(Color.systemGray6)
                            .cornerRadius(8)
                    })
                }
                
                if showPlus {
                    Button(action: {
                        habit.currentCount -= 1
                        WidgetCenter.shared.reloadTimelines(ofKind: "WidgetExtension")
                    }, label: {
                        Image(systemName: "plus")
                            .foregroundColor(.primary)
                            .frame(width: 48, height: 48)
                            .background(Color.systemGray6)
                            .cornerRadius(8)
                    })
                }
            }
            .padding(.top, 32)
            Spacer()
        }
        .padding(.top, 48)
        .onChange(of: habit.currentCount, {
            withAnimation{
                updateButtons()
            }
        })
        .onAppear{
            updateButtons()
        }
    }
    
    func updateButtons(){
        showReturn = habit.currentCount < habit.maxCount
        showPlus = habit.currentCount > 0
    }
}

#Preview {
    var newHabit = Habit.testHabit
    return HabitView(habit: newHabit)
}
