//
//  CalendarHelper.swift
//  DailyNest
//
//  Created by Atakan on 19.03.2026.
//

import Foundation
import Observation

@Observable
class CalendarHelper {
    var calendar: Calendar = {
        var cal = Calendar.current
        cal.firstWeekday = 1 // 1 = Pazar
        return cal
    }()

    /// Bulunduğumuz Hafta günleri.
    func weekDays(for date: Date) -> [Date] {
        guard let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: date)?.start else { return [] }
        return (0 ..< 7).compactMap {
            calendar.date(byAdding: .day, value: $0, to: startOfWeek)
        }
    }

    /// Belirli bir ayın tüm Haftaları
    func weeksInMonth(for date: Date) -> [[Date]] {
        guard let startOfMonth = calendar.dateInterval(of: .month, for: date)?.start,
              let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: startOfMonth)?.start,
              let monthEnd = calendar.dateInterval(of: .month, for: date)?.end else { return [] }

        var weeks: [[Date]] = []
        var current = startOfWeek

        while current < monthEnd {
            let week = (0 ..< 7).compactMap {
                calendar.date(byAdding: .day, value: $0, to: current)
            }
            weeks.append(week)
            guard let next = calendar.date(byAdding: .weekOfYear, value: 1, to: current) else { break }
            current = next
        }
        return weeks
    }

    func nextMounth(after date: Date) -> Date {
        var components = calendar.dateComponents([.year, .month], from: date)
        components.month = (components.month ?? 0) + 1
        return calendar.date(from: components) ?? date
    }

    func previousMounth(before date: Date) -> Date {
        var components = calendar.dateComponents([.year, .month], from: date)
        components.month = (components.month ?? 0) - 1
        return calendar.date(from: components) ?? date
    }

    func nextWeek(after date: Date) -> Date {
        calendar.date(byAdding: .weekOfYear, value: 1, to: date) ?? date
    }

    func previousWeek(before date: Date) -> Date {
        calendar.date(byAdding: .weekOfYear, value: -1, to: date) ?? date
    }

    func monthTitle(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter.string(from: date).capitalized
    }

    func isToday(_ date: Date) -> Bool {
        calendar.isDateInToday(date)
    }

    func isSameDay(_ date1: Date, _ date2: Date) -> Bool {
        calendar.isDate(date1, inSameDayAs: date2)
    }

    func isCurrentMonth(_ date: Date, reference: Date) -> Bool {
        calendar.isDate(date, equalTo: reference, toGranularity: .month)
    }

    func formatDate(_ date: Date, _ style: DateFormatter.Style) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = style
        return formatter.string(from: date)
    }

    func formatDateTime(_ date: Date, _ style: DateFormatter.Style) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = style
        return formatter.string(from: date)
    }

    func getDaytime() -> String {
        let hour = calendar.component(.hour, from: Date())
        if hour < 13 { return "Good Morning," }
        if hour < 19 { return "Hello," }
        return "Good Evening,"
    }

    func formattedDate() -> String {
        Date().formatted(.dateTime.weekday(.wide).day().month(.wide))
    }
}
