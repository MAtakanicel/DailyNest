//
//  ProjectTask.swift
//  DailyNest
//
//  Created by Atakan on 26.04.2026.
//

import Foundation
import SwiftData

@Model
final class ProjectTask :Taskable {
    
    var id: UUID = UUID()
    var title: String
    var details: String?
    var priority: TaskPriority
    var order: Int = 0 // sıralama için
   
    var isCompleted: Bool
    
    var startDate: Date?
    var deadline: Date?
    var completedAt: Date?
    var createdAt: Date
    
    var isReminderOn: Bool
    var reminderDate: Date?

    @Relationship(deleteRule: .nullify, inverse: \Project.projectTask)
    var project: Project?

    init(
        title: String,
        details:String?,
        priority: TaskPriority,
        order: Int = 0,
        isReminderOn: Bool = false,
        reminderDate: Date? = nil,
        
    ) {
        self.title = title
        self.details = details
        self.priority = priority
        self.order = order
        self.isReminderOn = isReminderOn
        self.reminderDate = reminderDate
        
        //varsayılan
        createdAt = .now
        isCompleted = false
    }
}

