
import Foundation


struct Task: Schedulable {
    let id: UUID
    var description: String?
    var isReminder: Bool
    var title: String
    var createdAt: Date
    var date: Date?
    var isCompleted: Bool
    var completedAt: Date?
    var priority: ToDoPriority?
    var reminderDate: Date?
    
    init(id: UUID, description: String? = nil, isReminder: Bool, title: String, createdAt: Date, date: Date? = nil, isCompleted: Bool, completedAt: Date? = nil, priority: ToDoPriority? = nil, reminderDate: Date? = nil) {
        self.id = id
        self.description = description
        self.isReminder = isReminder
        self.title = title
        self.createdAt = createdAt
        self.date = date
        self.isCompleted = isCompleted
        self.completedAt = completedAt
        self.priority = priority
        self.reminderDate = reminderDate
    }
    }
