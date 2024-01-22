//
//  WidgetExtension.swift
//  WidgetExtension
//
//  Created by Александр Новиков on 22.01.2024.
//

import WidgetKit
import SwiftUI
import SwiftData

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
        return habits ?? []
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let habits: [Habit]
}

struct WidgetExtensionEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text("Time:")
            Text(entry.date, style: .time)

            Text("Habit (\(entry.habits.count)):")
            Text(entry.habits.first?.title ?? "")
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
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

#Preview(as: .systemSmall) {
    WidgetExtension()
} timeline: {
    SimpleEntry(date: .now, habits: [.testHabit])
    SimpleEntry(date: .now, habits: [.testHabit])
}
