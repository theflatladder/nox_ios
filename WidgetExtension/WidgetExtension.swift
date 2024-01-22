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
        if [.systemSmall, .systemMedium].contains(widgetStyle){
            let row1 = widgetStyle == .systemSmall ? [0,1] : [0,1,2,3]
            let row2 = widgetStyle == .systemSmall ? [2,3] : [4,5,6,7]
            VStack(spacing: 24){
                HStack(spacing: 24){
                    ForEach(row1, id: \.self){
                        ProgressRing(habit: entry.habits.getByIndex($0), size: 48, showEmoji: true)
                    }
                }
                HStack(spacing: 24){
                    ForEach(row2, id: \.self){
                        ProgressRing(habit: entry.habits.getByIndex($0), size: 48, showEmoji: true)
                    }
                }
            }
        }
        
        if widgetStyle == .systemLarge{
            VStack(spacing: 16){
                ForEach(0..<8){
                    let habit = entry.habits.getByIndex($0)
                    HStack(spacing: 16){
                        ProgressRing(habit: habit, size: 24)
                        Text(habit?.title ?? "-----")
                            .font(.RubikRegular(16))
                            .foregroundColor(habit == nil || habit!.currentCount == 0 ? .systemGray2 : .primary)
                        Spacer()
                        Text(habit == nil ? "" : "\(habit?.currentCount ?? 0)")
                            .font(.RubikRegular(16))
                            .foregroundColor(habit == nil || habit!.currentCount == 0 ? .systemGray2 : .primary)
                    }
                }
            }
            .padding(16)
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
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
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
        
        WidgetCenter.shared.reloadAllTimelines()
        return .result()
    }
}

#Preview(as: .systemSmall) {
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
