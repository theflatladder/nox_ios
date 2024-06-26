//
//  MonthView.swift
//  Nox
//
//  Created by Александр Новиков on 25.04.2024.
//

import SwiftUI

struct MonthView: View {
    
    var month: Date
    var records: [MoodRecord]
    
    @Binding var months: [Date:[MoodRecord]]
    @State private var moodEditingPresented = false
    @State private var dayInEdit = Date?.none
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
            ForEach(getDays(), id: \.self) { day in
                if let day = day {
                    Text(day.formatted(.dateTime.day()))
                        .frame(width: 36, height: 36)
                        .font(.RubikRegular(16))
                        .foregroundStyle(.primary)
                        .background(
                            Circle()
                                .foregroundStyle(records.first(where: {$0.date == day})?.color.opacity(0.3) ?? .systemGray5)
                        )
                        .overlay{
                            Circle()
                                .stroke(style: StrokeStyle(lineWidth: 1))
                                .fill(day == .today ? Color.additional : Color.clear)
                        }
                        .onTapGesture{
                            dayInEdit = day
                        }
                } else {
                    Text("")
                }
            }
        }
        .onChange(of: dayInEdit){
            moodEditingPresented = dayInEdit != nil
        }
        .onChange(of: moodEditingPresented){
            if !moodEditingPresented{
                dayInEdit = nil
            }
        }
        .sheet(isPresented: $moodEditingPresented, content: {
            MoodEditor(dayInEdit: $dayInEdit, moodEditingPresented: $moodEditingPresented, months: $months)
                .presentationDetents([.height(150)])
                .presentationDragIndicator(.visible)
        })
    }
    
    private func getDays() -> [Date?]{
        var days = [Date?]()
        var day = month.firstDayOfMonth
        repeat{
            days.append(day)
            day = Calendar.current.date(byAdding: .day, value: 1, to: day)!
        } while Calendar.current.component(.day, from: day) != 1
        
        var weekDay = 0
        let firstDayOfMonthWeekDay = Calendar.current.component(.weekday, from: days[0]!) - 2
        while weekDay < firstDayOfMonthWeekDay{
            days.insert(nil, at: 0)
            weekDay += 1
        }
        
        return days
    }
}

#Preview {
    @State var months = [Date:[MoodRecord]]()
    return MonthView(month: Date(), records: [
        MoodRecord(date: Date(), value: .Good)
    ], months: $months)
    .modelContainer(for: MoodRecord.self, inMemory: true)
}
