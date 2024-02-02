//
//  MainFocusWidget.swift
//  MainFocusWidget
//
//  Created by Александр Новиков on 23.01.2024.
//

import WidgetKit
import SwiftUI
import AppIntents

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
    @Environment(\.widgetFamily) var widgetStyle
    @AppStorage("current_target", store: UserDefaults(suiteName: "group.com.theflatladder.Nox")) var currentTarget = ""
    var entry: Provider.Entry

    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Spacer()
                    Button(intent: RefreshTapIntent(), label: {
                        Image(systemName: "arrow.clockwise")
                            .foregroundColor(Color.primary)
                            .font(.system(size: 12))
                    })
                    .buttonStyle(.plain)
                }
                Spacer()
            }
            VStack(spacing: widgetStyle == .systemSmall ? 8 : 16) {
                Text("🎯 \(currentTarget)")
                    .font(.RubikSemiBold(14))
                Text(entry.quote)
                    .font(.RubikRegular(widgetStyle == .systemSmall ? 12 : 14))
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.01)
            }
            .padding(widgetStyle == .systemSmall ? 0 : 8)
        }
    }
}

struct RefreshTapIntent: AppIntent{
    
    static var title: LocalizedStringResource = "RefreshTap"
    
    @MainActor
    func perform() async throws -> some IntentResult {
        WidgetCenter.shared.reloadTimelines(ofKind: "MainFocusWidget")
        return .result()
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
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

#Preview(as: .systemSmall) {
    MainFocusWidget()
} timeline: {
    SimpleEntry(date: .now)
}
