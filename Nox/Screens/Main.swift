//
//  ContentView.swift
//  Nox
//
//  Created by Александр Новиков on 17.01.2024.
//

import SwiftUI
import SwiftData
import WidgetKit

struct Main: View {
    
    @Environment(\.modelContext) private var context
    @AppStorage("current_target", store: UserDefaults(suiteName: "group.com.theflatladder.Nox")) var currentTarget = ""
    
    @Query private var habits: [Habit]
    @State private var addHabitSheet = false
    @State private var changeTargetSheet = false
    
    var body: some View {
        NavigationView{
            ZStack(alignment: .bottomTrailing) {
                
                //list of habits
                List {
                    ForEach(habits.sorted(by: { $0.creationDate < $1.creationDate })) { habit in
                        HabitListView(habit: habit)
                        
                            .overlay(
                                NavigationLink(
                                    destination: { HabitView(habit: habit) },
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
                Button(action: { addHabitSheet.toggle() }){
                    Image(systemName: "plus")
                        .frame(width: 48, height: 48)
                        .foregroundColor(Color.white)
                        .background(Color.accentColor)
                        .clipShape(Circle())
                        .padding(16)
                }
                
                //add habit sheet
                .sheet(isPresented: $addHabitSheet) {
                    AddHabit(save: { newHabit in
                        withAnimation {
                            context.insert(newHabit)
                        }
                        addHabitSheet.toggle()
                        WidgetCenter.shared.reloadTimelines(ofKind: "WidgetExtension")
                    })
                    .presentationDetents([.height(500)])
                    .presentationDragIndicator(.visible)
                }
            }
            .navigationTitle("Nox")
            .toolbar(content: {
                
                //mood tracking transition
                NavigationLink(
                    destination: { MoodTrackingView() },
                    label: {
                        Image(systemName: "calendar")
                            .foregroundColor(Color.primary)
                    }
                )
                
                //change target sheet
                Button(action: {
                    changeTargetSheet.toggle()
                }, label: {
                    Image(systemName: "target")
                        .foregroundColor(Color.primary)
                })
                .sheet(isPresented: $changeTargetSheet) {
                    VStack{
                        MyTextField(title: "Current target", value: $currentTarget)
                            .padding(16)
                        Spacer()
                    }
                    .padding(.top, 16)
                    .presentationDetents([.height(200)])
                    .presentationDragIndicator(.visible)
                }
            })
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
