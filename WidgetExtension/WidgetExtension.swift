//
//  WidgetExtension.swift
//  WidgetExtension
//
//  Created by Александр Новиков on 22.01.2024.
//

import WidgetKit
import SwiftUI
import SwiftData
import AppIntents

struct Provider: TimelineProvider {
    @MainActor func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), habits: getHabits())
    }

    @MainActor func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), habits: getHabits())
        completion(entry)
    }

    @MainActor func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let timeline = Timeline(entries: [
            SimpleEntry(date: .now, habits: getHabits())
        ], policy: .after(.now.advanced(by: 60*5)))
        completion(timeline)
    }
    
    @MainActor
    func getHabits() -> [Habit]{
        guard
            let modelContainer = try? ModelContainer(for: Habit.self)
        else { return [] }
        let descriptor = FetchDescriptor<Habit>()
        let habits = try? modelContainer.mainContext.fetch(descriptor)
        return habits?.sorted(by: { $0.creationDate < $1.creationDate }) ?? []
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let habits: [Habit]
}

struct WidgetExtensionEntryView : View {
    @Environment(\.widgetFamily) var widgetStyle
    
    var entry: Provider.Entry
    
    var body: some View {
        if widgetStyle == .systemSmall{
            VStack(spacing: 24){
                ForEach([[0,1], [2,3]], id: \.self){pair in
                    HStack(spacing: 24){
                        ForEach(pair, id: \.self){
                            ProgressRing(habit: entry.habits.getByIndex($0), size: 48, tapActive: true, emoji: true)
                        }
                    }
                }
            }
        }
        
        if widgetStyle == .systemMedium{ //TODO: make foreach without doubling HabitLine
            HStack{
                VStack(spacing: 8){
                    ForEach([0,2,4,6], id: \.self){
                        HabitLine(habit: entry.habits.getByIndex($0))
                    }
                }
                VStack(spacing: 8){
                    ForEach([1,3,5,7], id: \.self){
                        HabitLine(habit: entry.habits.getByIndex($0))
                    }
                }
            }
            .padding(8)
        }
    }
}

struct HabitLine : View {
    
    var habit: Habit?
    
    var body: some View {
        HStack(spacing: 16){
            ProgressRing(habit: habit, size: 22, tapActive: true, emoji: false)
            Text(habit?.title ?? "-----")
                .padding(.leading, -8) //TODO: find the actual spacing and remove this line
                .font(.RubikRegular(14))
                .foregroundColor(habit == nil || habit!.currentCount == 0 ? .systemGray2 : .primary)
            Spacer()
        }
    }
}

struct WidgetExtension: Widget {
    let kind: String = "WidgetExtension"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WidgetExtensionEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Habits")
        .description("Easy tap straight from your home screen.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct HabitTapIntent: AppIntent{
    
    static var title: LocalizedStringResource = "HabitTap"
    
    @Parameter(title: "habitId")
    var habitId: String?
    
    init(){ }
    init(habitId: String?) {
        self.habitId = habitId
    }
    
    @MainActor
    func perform() async throws -> some IntentResult {
        let modelContainer = try ModelContainer(for: Habit.self)
        let descriptor = FetchDescriptor<Habit>()
        let habits = try modelContainer.mainContext.fetch(descriptor)
        let habit = habits.first(where: {$0.id == habitId})
        habit?.currentCount = max(0, (habit?.currentCount ?? 0) - 1)
        try modelContainer.mainContext.save()
        
        WidgetCenter.shared.reloadTimelines(ofKind: "WidgetExtension")
        return .result()
    }
}

#Preview(as: .systemMedium) {
    WidgetExtension()
} timeline: {
    let modelContainer = try? ModelContainer(for: Habit.self)
    SimpleEntry(date: .now, habits: [.testHabit])
}



extension Array{
    func getByIndex(_ index: Int) -> Element?{
        if indices.contains(index) {
            return self[index]
        }
        return nil
    }
}
