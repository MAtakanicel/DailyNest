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
        guard let startOfMonth = calendar.dateInterval(of: .month, for: date)?.start else { return [] }
        guard let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: startOfMonth)?.start else { return [] }

        var weeks: [[Date]] = []
        var current = startOfWeek

        while current < calendar.dateInterval(of: .month, for: date)!.end {
            let week = (0 ..< 7).compactMap {
                calendar.date(byAdding: .day, value: $0, to: current)
            }
            weeks.append(week)
            current = calendar.date(byAdding: .weekOfYear, value: 1, to: current)!
        }
        return weeks
    }

    func nextMounth(after date: Date) -> Date {
        var components = calendar.dateComponents([.year, .month], from: date)
        components.month! += 1
        return calendar.date(from: components)!
    }

    func previousMounth(before date: Date) -> Date {
        var components = calendar.dateComponents([.year, .month], from: date)
        components.month! -= 1
        return calendar.date(from: components)!
    }

    func nextWeek(after date: Date) -> Date {
        calendar.date(byAdding: .weekOfYear, value: 1, to: date)!
    }

    func previousWeek(before date: Date) -> Date {
        calendar.date(byAdding: .weekOfYear, value: -1, to: date)!
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
}
