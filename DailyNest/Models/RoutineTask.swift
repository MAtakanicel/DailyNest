//
//  RoutineTask.swift
//  DailyNest
//
//  Created by Atakan on 30.01.2026.
//

import Foundation
import SwiftData

@Model
final class RoutineTask {
    var title: String
    var details: String? // Description

    var routineDays: [WeekDay]

    var completionHistory: [Date]

    var isReminderOn: Bool
    var reminderTime: Date?

    var createdAt: Date

    var icon: String = "list.bullet"

    var tintColor: String = "blue"

    init(title: String,
         details: String? = nil,
         routineDays: [WeekDay] = [.monday, .tuesday, .wednesday, .thursday, .friday], // Varsayılan: Hafta içi
         isReminderOn: Bool = false,
         reminderTime: Date? = nil)
    {
        self.title = title
        self.details = details
        self.routineDays = routineDays
        self.isReminderOn = isReminderOn
        self.reminderTime = reminderTime

        createdAt = .now
        completionHistory = []
    }

    /// Bugün yapıldı mı kontrolü
    var isCompletedToday: Bool {
        completionHistory.contains { Calendar.current.isDateInToday($0) }
    }
}
