

import Foundation

struct Routine: Schedulable {
    let id: UUID
    var description: String?
    var isReminder: Bool
    var title: String
    var createdAt: Date
    var routineDays: [WeekDay]
    var isCompletedToday: Bool
    var reminderTime: Date?
    
    init(id: UUID, description: String? = nil, isReminder: Bool, title: String, createdAt: Date, routineDays: [WeekDay], isCompletedToday: Bool, reminderTime: Date? = nil) {
        self.id = id
        self.description = description
        self.isReminder = isReminder
        self.title = title
        self.createdAt = createdAt
        self.routineDays = routineDays
        self.isCompletedToday = isCompletedToday
        self.reminderTime = reminderTime
    }
}
