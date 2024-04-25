//
//  MoodEditor.swift
//  Nox
//
//  Created by Александр Новиков on 26.04.2024.
//

import SwiftUI
import SwiftData

struct MoodEditor: View {
    
    @Environment(\.modelContext) private var context
    @Binding var dayInEdit: Date?
    @Binding var moodEditingPresented: Bool
    @Binding var months: [Date:[MoodRecord]]
    
    var body: some View {
        VStack(spacing: 16){
            Text(dayInEdit?.formatted(date: .abbreviated, time: .omitted) ?? "")
            HStack(spacing: 16){
                ForEach(MoodValue.allCases){moodValue in
                    Text(moodValue.title)
                        .font(.RubikRegular(16))
                        .padding(8)
                        .background(moodValue.color.opacity(0.3))
                        .cornerRadius(8)
                        .onTapGesture {
                            if let dayInEdit{
                                months.flatMap({ $0.value }).filter({ $0.date == dayInEdit }).forEach({
                                    context.delete($0)
                                })
                                
                                let newRecord = MoodRecord(date: dayInEdit, value: moodValue)
                                context.insert(newRecord)
                                try? context.save()
                                
                                var arr = months[dayInEdit.firstDayOfMonth]?.filter({$0.date != dayInEdit}) ?? []
                                arr.append(newRecord)
                                months[dayInEdit.firstDayOfMonth] = arr
                            }
                            moodEditingPresented = false
                        }
                }
            }
        }
    }
}

#Preview {
    @State var dayInEdit: Date? = nil
    @State var moodEditingPresented: Bool = false
    @State var months = [Date:[MoodRecord]]()
    return MoodEditor(dayInEdit: $dayInEdit, moodEditingPresented: $moodEditingPresented, months: $months)
}
