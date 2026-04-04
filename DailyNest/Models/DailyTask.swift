//
//  DailyTask.swift
//  DailyNest
//
//  Created by Atakan on 30.01.2026.
//

import Foundation
import SwiftData

@Model
final class DailyTask: Taskable {
    var id: UUID = UUID()

    var title: String
    var details: String // Description
    var date: Date // Gerçekleştirilicek tarih
    var createdAt: Date

    var priority: TaskPriority

    var isReminderOn: Bool
    var reminderDate: Date

    var isCompleted: Bool
    var completedAt: Date?

    @Relationship(deleteRule: .nullify)
    var category: [ObjectCategory] = []
    
    init(
        title: String = "",
        details: String = "",
        date: Date = .now,
        priority: TaskPriority = .medium,
        isReminderOn: Bool = false,
        reminderDate: Date = .now,
        isCompleted: Bool = false,
        completedAt: Date? = nil
    ) {
        // Alınacak veriler
        self.title = title
        self.details = details
        self.priority = priority
        self.date = date
        self.isReminderOn = isReminderOn
        self.reminderDate = reminderDate

        // UI'da yok
        self.isCompleted = isCompleted
        self.completedAt = completedAt

        // Varsayılanlar
        createdAt = .now
    }
}
