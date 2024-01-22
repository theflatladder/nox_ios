//
//  ProgressPicker.swift
//  Nox
//
//  Created by Александр Новиков on 19.01.2024.
//

import SwiftUI

struct PeriodPicker: View {
    
    @Binding var period: Period
    
    var body: some View {
        VStack{
            HStack{
                Text("Refresh every")
                    .font(.RubikRegular(14))
                    .foregroundColor(Color.systemGray)
                Spacer()
            }
            Picker("", selection: $period) {
                ForEach(Period.allCases){
                    Text($0.title)
                        .tag($0.rawValue)
                }
            }
            .pickerStyle(.segmented)
        }
    }
}

#Preview {
    @State var period: Period = .Weekly
    @Bindable var newHabit = Habit()
    return PeriodPicker(period: $newHabit.period)
}
