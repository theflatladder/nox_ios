//
//  AddHabit.swift
//  Nox
//
//  Created by Александр Новиков on 18.01.2024.
//

import SwiftUI

struct AddHabit: View {
    
    @Bindable private var newHabit = Habit()
    var save: (Habit)->()
    
    var body: some View {
        VStack(spacing: 24){
            Text("New habit")
                .font(.RubikSemiBold(24))
                .padding(.top, 16)
            HStack(spacing: 16){
                MyTextField(title: "Title", value: $newHabit.title)
                MyTextField(title: "Emoji", value: $newHabit.emoji)
                    .frame(width: 80)
            }
            MyStepper(title: "Max count", value: $newHabit.maxCount)
            PeriodPicker(period: $newHabit.period)
            Button("Save", action: {
                newHabit.currentCount = newHabit.maxCount
                save(newHabit)
            })
            .foregroundColor(Color.primary)
            .buttonStyle(.bordered)
            .padding(16)
            Spacer()
        }
        .background(.background)
        .padding(16)
    }
    
    
}

#Preview {
    AddHabit(save: {_ in })
}
