//
//  MonthView.swift
//  Nox
//
//  Created by Александр Новиков on 25.04.2024.
//

import SwiftUI

struct MonthView: View {
    
    var month: Date
    private var today: Date {
        let now = Date()
        var dateComponents = DateComponents()
        dateComponents.day = Calendar.current.component(.day, from: now)
        dateComponents.month = Calendar.current.component(.month, from: now)
        dateComponents.year = Calendar.current.component(.year, from: now)
        dateComponents.timeZone = TimeZone(abbreviation: "UTC")
        return Calendar.current.date(from: dateComponents)!
    }
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
            ForEach(getDays(), id: \.self) { day in
                if let day = day {
                    Text(day.formatted(.dateTime.day()))
                        .frame(width: 36, height: 36)
                        .font(.RubikRegular(16))
                        .foregroundStyle(day == today ? .white : .black)
                        .background(
                            Circle()
                                .foregroundStyle(
                                    Color(day == today ? Color.accent : Color.additional)
                                )
                        )
                } else {
                    Text("")
                }
            }
        }
    }
    
    private func getDays() -> [Date?]{
        var dateComponents = DateComponents()
        dateComponents.day = 1
        dateComponents.month = Calendar.current.component(.month, from: month)
        dateComponents.year = Calendar.current.component(.year, from: month)
        dateComponents.timeZone = TimeZone(abbreviation: "UTC")
        var day = Calendar.current.date(from: dateComponents)!
        
        var days = [Date?]()
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
    MonthView(month: Calendar.current.date(byAdding: .month, value: -1, to: Date())!)
}
