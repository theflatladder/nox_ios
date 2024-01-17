//
//  ContentView.swift
//  Nox
//
//  Created by Александр Новиков on 17.01.2024.
//

import SwiftUI
import SwiftData

struct Main: View {
    
    @Environment(\.modelContext) private var context
    
    @Query private var habits: [Habit]
    
    var body: some View {
        NavigationView{
            ZStack(alignment: .bottomTrailing) {
                List {
                    ForEach(habits) { habit in
                        NavigationLink {
                            Text(habit.title)
                        } label: {
                            HabitView(habit: habit)
                        }
                    }
                    .onDelete(perform: deleteHabit)
                }
                Button(action: addHabit){
                    Image(systemName: "plus")
                        .frame(width: 48, height: 48)
                        .foregroundColor(Color.white)
                        .background(Color.accentColor)
                        .clipShape(Circle())
                        .padding(16)
                }
            }
            .navigationTitle("Nox")
        }
    }
    
    private func addHabit() {
        withAnimation {
            context.insert(Habit(title: "Test", maxCount: 10, currentCount: 3))
        }
    }
    
    private func deleteHabit(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                context.delete(habits[index])
            }
        }
    }
}

#Preview {
    Main()
        .modelContainer(for: Habit.self, inMemory: true)
}
