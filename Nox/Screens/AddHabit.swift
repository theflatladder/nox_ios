//
//  AddHabit.swift
//  Nox
//
//  Created by Александр Новиков on 18.01.2024.
//

import SwiftUI

struct AddHabit: View {
    
    @State var newHabit = Habit()
    
    var body: some View {
        VStack(spacing: 24){
            Text("New habit")
                .font(.RubikSemiBold(24))
                .foregroundColor(Color.accentColor)
                .padding(.top, 16)
            MyTextField(title: "Title", value: $newHabit.title)
            MyStepper(title: "Max count", value: $newHabit.maxCount)
            Spacer()
        }
        .padding(16)
        .onTapGesture { //need to be on tap of the whole sheet somehow
            UIApplication.shared.endEditing()
        }
    }
    
    
}

#Preview {
    AddHabit()
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
