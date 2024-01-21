//
//  MyStepper.swift
//  Nox
//
//  Created by Александр Новиков on 18.01.2024.
//

import SwiftUI

struct MyStepper: View {
    
    var title: String
    @Binding var value: Int
    
    var body: some View {
        HStack{
            MyNumTextField(title: title, value: $value)
            
            HStack{
                Button(action: {
                    value = max(0, value - 1)
                }, label: {
                    Image(systemName: "minus")
                        .foregroundColor(.black)
                })
                .frame(width: 48, height: 32)
                
                Spacer()
                    .frame(width: 1, height: 16)
                    .background(Color.systemGray4)
                
                Button(action: {
                    value += 1
                }, label: {
                    Image(systemName: "plus")
                        .foregroundColor(.black)
                })
                .frame(width: 48, height: 32)
            }
            .frame(width: 97, height: 32)
            .background(Color.systemGray6)
            .cornerRadius(8)
            .padding(.top, 20)
            .padding(20)
            
            Spacer()
        }
    }
}

#Preview {
    @Bindable var habit = Habit.testHabit
    return MyStepper(title: "Max count", value: $habit.maxCount)
}
