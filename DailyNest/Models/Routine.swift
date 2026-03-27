//
//  Routine.swift
//  DailyNest
//
//  Created by Atakan on 30.01.2026.
//

import Foundation
import SwiftData

@Model
final class Routine {
    var id: UUID = UUID()

    var title: String
    var details: String // Description
    var icon: String
    
    var routineDays: [WeekDay]
    var maxCount: Int = 1
  
    var tintColor: RoutineColor
    var priority: TaskPriority

    var isReminderOn: Bool
    var reminderTime: Date

    @Relationship(deleteRule: .cascade)
    var completionHistory: [DailyLog]
    var createdAt: Date

    init(
        title: String = "",
        details: String = "",
        icon: String = "list.bullet",
        routineDays: [WeekDay] = [.monday, .tuesday, .wednesday, .thursday, .friday], // Varsayılan: Hafta içi
        maxCount: Int = 1,
        tintColor: RoutineColor = .blue,
        priority: TaskPriority = .medium,
        isReminderOn: Bool = false,
        reminderTime: Date = .now
    ) {
        self.title = title
        self.details = details
        self.icon = icon
        self.routineDays = routineDays
        self.maxCount = maxCount
        self.tintColor = tintColor
        self.priority = priority
        self.isReminderOn = isReminderOn
        self.reminderTime = reminderTime
 

        
        createdAt = .now
        completionHistory = []
    }

    /// Bugün yapıldı mı kontrolü
    var isCompletedToday: Bool {
        let today = completionHistory.first(where: { Calendar.current.isDateInToday($0.date) })
        guard let completion = today else { return false }

        return completion.todaysCompletionCount == maxCount
    }
}

@Model
final class DailyLog {
    var date: Date
    var todaysCompletionCount: Int

    init(date: Date, todaysCompletionCount: Int = 0) {
        self.date = date
        self.todaysCompletionCount = todaysCompletionCount
    }
}
