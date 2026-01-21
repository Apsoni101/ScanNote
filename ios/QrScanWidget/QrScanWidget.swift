//
//  QrScanWidget.swift
//  QrScanWidget
//
//  Created by coditas on 20/01/26.
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
}

struct QrScanWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack(alignment: .topLeading) {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.129, green: 0.596, blue: 0.953),
                    Color(red: 0.08, green: 0.52, blue: 0.92)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            Circle()
                .fill(
                    RadialGradient(
                        gradient: Gradient(colors: [
                            Color.white.opacity(0.4),
                            Color.white.opacity(0)
                        ]),
                        center: UnitPoint(x: 0, y: 0.5),
                        startRadius: 10,
                        endRadius: 120
                    )
                )
                .frame(width: 200, height: 150)
                .position(x: -40, y: 60)
            
            Circle()
                .fill(
                    RadialGradient(
                        gradient: Gradient(colors: [
                            Color.white.opacity(0.4),
                            Color.white.opacity(0)
                        ]),
                        center: UnitPoint(x: 1, y: 0.5),
                        startRadius: 10,
                        endRadius: 120
                    )
                )
                .frame(width: 200, height: 150)
                .position(x: 150, y: 60)
            
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 0) {
                

                    ZStack {
                        Circle()
                            .fill(Color.white.opacity(0.1))
                            .frame(width: 50, height: 50)
                        
                        Image(systemName: "qrcode")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32, height: 32)
                            .foregroundColor(.white)
                    }
                    .padding(.trailing, 6)
                }
                .frame(height: 60)

                Spacer()

                VStack(alignment: .leading, spacing: 3) {
                    Text("Scan QR Codes.")
                        .font(.system(size: 11, weight: .regular, design: .default))
                        .foregroundColor(.white.opacity(0.8))
                        .lineLimit(1)

                    Text("Store Securely.")
                        .font(.system(size: 11, weight: .regular, design: .default))
                        .foregroundColor(.white.opacity(0.8))
                        .lineLimit(1)

                    Text("Google Sheets Ready.")
                        .font(.system(size: 12, weight: .bold, design: .default))
                        .foregroundColor(.white)
                        .lineLimit(1)
                }
                .padding(.leading, 8)
                .padding(.bottom, 8)
            }
            .padding(8)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

struct QrScanWidget: Widget {
    let kind: String = "QrScanWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                QrScanWidgetEntryView(entry: entry)
                    .containerBackground(.fill.secondary, for: .widget)
            } else {
                QrScanWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .contentMarginsDisabled() //
        .configurationDisplayName("QR Scanner")
        .description("Scan QR codes and store them securely")
        .supportedFamilies([.systemSmall])
    }
}

#Preview(as: .systemSmall) {
    QrScanWidget()
} timeline: {
    SimpleEntry(date: .now)
}
