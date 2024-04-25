//
//  MoodTrackingView.swift
//  Nox
//
//  Created by Александр Новиков on 25.04.2024.
//

import SwiftUI

struct MoodTrackingView: View {
    
    var test = [
        Calendar.current.date(byAdding: .month, value: -2, to: Date())!,
        Calendar.current.date(byAdding: .month, value: -1, to: Date())!,
        Calendar.current.date(byAdding: .month, value: 0, to: Date())!,
        Calendar.current.date(byAdding: .month, value: 1, to: Date())!,
        Calendar.current.date(byAdding: .month, value: 2, to: Date())!,
    ]
    
    var body: some View {
        
        List{
            ForEach(test, id: \.self){month in
                VStack(spacing: 4){
                    HStack{
                        Spacer()
                        Text(month.formatted(.dateTime.month(.wide)))
                            .font(.RubikRegular(14))
                            .foregroundStyle(.primary)
                            .padding(.bottom, 8)
                    }
                    MonthView(month: month)
                }
                .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
        .navigationTitle("Mood tracking")
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

#Preview {
    MoodTrackingView()
}
