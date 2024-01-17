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
                
                //list of habits
                List {
                    ForEach(habits) { habit in
                        HabitView(habit: habit)
                            .overlay(
                                NavigationLink(
                                    destination: { Text(habit.title) },
                                    label: { EmptyView() }
                                ).opacity(0)
                            )
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                            .listRowInsets(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
                    }
                    .onDelete(perform: deleteHabit)
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .background(Color.systemGray6)
                
                //add button
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
            context.insert(Habit(title: "Test", maxCount: 10, currentCount: .random(in: 1..<10)))
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
