//
//  MainFocusWidget.swift
//  MainFocusWidget
//
//  Created by Александр Новиков on 23.01.2024.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    var quote: String {
        Quotes.getRandomQuote()
    }
}

struct MainFocusWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack(spacing: 16) {
            Text("🎯 Sleep")
                .font(.RubikSemiBold(14))
            Text(entry.quote)
                .font(.RubikRegular(14))
                .multilineTextAlignment(.center)
        }
        .padding(16)
    }
}

struct MainFocusWidget: Widget {
    let kind: String = "MainFocusWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            MainFocusWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Main focus")
        .description("Keep your purpous in front of you")
        .supportedFamilies([.systemMedium])
    }
}

#Preview(as: .systemMedium) {
    MainFocusWidget()
} timeline: {
    SimpleEntry(date: .now)
}
