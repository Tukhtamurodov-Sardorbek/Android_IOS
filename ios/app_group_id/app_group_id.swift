//
//  app_group_id.swift
//  app_group_id
//
//  Created by Macbook on 28/08/23.
//

import WidgetKit
import SwiftUI
import Intents

private let groupName = "group.app_group_name"

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), title: "Placeholder Title", description: "Placeholder Description", filename: "No Screenshot", configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let data = UserDefaults.init(suiteName: groupName)
        
        let entry = SimpleEntry(date: Date(), title: data?.string(forKey: "title") ?? "No title", description: data?.string(forKey: "description") ?? "No description", filename: data?.string(forKey: "filename") ?? "No screenshot", configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
//        var entries: [SimpleEntry] = []
//
//        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
//        let currentDate = Date()
//        for hourOffset in 0 ..< 5 {
//            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//            let entry = SimpleEntry(date: entryDate, configuration: configuration)
//            entries.append(entry)
//        }
//
//        let timeline = Timeline(entries: entries, policy: .atEnd)
//        completion(timeline)
        getSnapshot(for: configuration, in: context) { (entry) in
            let timeline = Timeline(entries: [entry], policy: .atEnd)
            completion(timeline)
            
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let title: String
    let description: String
    let filename: String
    let configuration: ConfigurationIntent
}

struct app_group_idEntryView : View {
    var entry: Provider.Entry
    var ImageWidget: some View{
        if let uiImage = UIImage(contentsOfFile: entry.filename){
            let image = Image(uiImage: uiImage)
            return AnyView(image)
        }
        print("The image file could not be found")
        return AnyView(EmptyView())
    }

    var body: some View {
        VStack{
            ImageWidget
            Text(entry.title)
            Text(entry.description)
            Text(entry.date, style: .time)
        }
    }
}

struct app_group_id: Widget {
    let kind: String = "app_group_id"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            app_group_idEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct app_group_id_Previews: PreviewProvider {
    static var previews: some View {
        app_group_idEntryView(entry: SimpleEntry(date: Date(), title: "Example title", description: "Example description" , filename: "Example filename ", configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
