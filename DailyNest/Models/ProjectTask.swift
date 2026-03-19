//
//  ProjectTask.swift
//  DailyNest
//
//  Created by Atakan on 19.03.2026.
//
import Foundation
import SwiftData

@Model
final class ProjectTask :Taskable {
    var id: UUID = UUID()

    var title: String
    var details: String? // Description
    var createdAt: Date

    var priority: TaskPriority

    var isReminderOn: Bool
    var reminderDate: Date?

    var isCompleted: Bool
    var completedAt: Date?

    var startDate: Date?
    var deadline: Date?
    
    init(
        title: String,
        details: String? = nil,
        priority: TaskPriority = .medium,
        startDate: Date? = nil,
        deadline: Date? = nil,
        isReminderOn: Bool = false,
        reminderDate: Date? = nil,
        isCompleted: Bool = false,
        completedAt: Date? = nil
    ){
        self.title = title
        self.details = details
        self.priority = priority
        self.isReminderOn = isReminderOn
        self.reminderDate = reminderDate
        self.isCompleted = isCompleted
        self.completedAt = completedAt
        self.deadline = deadline
        self.startDate = startDate

        // Varsayılanlar
        createdAt = .now
    }
}
