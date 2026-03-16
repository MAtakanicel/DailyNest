//
//  DailyTask.swift
//  DailyNest
//
//  Created by Atakan on 30.01.2026.
//

import Foundation
import SwiftData

@Model
final class DailyTask {
    var title: String
    var details: String? // Description
    var date: Date // Gerçekleştirilicek tarih
    var createdAt: Date?

    var priority: TaskPriority

    var isReminderOn: Bool
    var reminderDate: Date?

    var isCompleted: Bool
    var completedAt: Date?

    init(title: String,
         details: String? = nil,
         date: Date = .now,
         priority: TaskPriority = .medium,
         isReminderOn: Bool = false,
         reminderDate: Date? = nil,
         isCompleted: Bool = false,
         completedAt: Date? = nil)
    {
        self.title = title
        self.details = details
        self.date = date
        self.priority = priority
        self.isReminderOn = isReminderOn
        self.reminderDate = reminderDate
        self.isCompleted = isCompleted
        self.completedAt = completedAt

        // Varsayılanlar
        createdAt = .now
    }
}
