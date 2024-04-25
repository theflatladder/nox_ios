//
//  MoodTrackingView.swift
//  Nox
//
//  Created by Александр Новиков on 25.04.2024.
//

import SwiftUI
import SwiftData

struct MoodTrackingView: View {
    
    @Environment(\.modelContext) private var context
    @State var months = [Date:[MoodRecord]]()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 16, content: {
                Spacer(minLength: UIScreen.main.bounds.height/4)
                ForEach(months.keys.sorted(by: >), id: \.self){month in
                    VStack(spacing: 4){
                        HStack{
                            Spacer()
                            Text(month.title)
                                .font(.RubikRegular(14))
                                .foregroundStyle(.primary)
                                .padding(.bottom, 8)
                                .padding(.trailing, 8)
                        }
                        MonthView(month: month, records: months[month] ?? [])
                    }
                    .reversed()
                }
            })
            .padding(.horizontal, 16)
        }
        .reversed()
        .onAppear{
            //load from database
            if let records = try? context.fetch(FetchDescriptor<MoodRecord>()){
                months = Dictionary(grouping: records, by: { $0.date.firstDayOfMonth })
            }
            //append 3 last months if needed
            let currentMonth = Date().firstDayOfMonth
            let requiredMonths = [
                Calendar.current.date(byAdding: .month, value: -2, to: currentMonth)!,
                Calendar.current.date(byAdding: .month, value: -1, to: currentMonth)!,
                Calendar.current.date(byAdding: .month, value:  0, to: currentMonth)!,
            ]
            requiredMonths
                .filter({ !months.keys.contains($0) })
                .forEach({ months[$0] = [] })
        }
        .navigationTitle("Mood tracking")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    MoodTrackingView()
        .modelContainer(for: MoodRecord.self, inMemory: true)
}

fileprivate extension Date{
    var title: String{
        let currentYear = Calendar.current.component(.year, from: Date())
        let year = self.year != currentYear ? " \(self.year)" : ""
        return self.formatted(.dateTime.month(.wide)) + year
    }
}

fileprivate extension View{
    func reversed() -> some View{
        self.rotationEffect(Angle(degrees: 180))
            .scaleEffect(x: -1.0, y: 1.0, anchor: .center)
    }
}
