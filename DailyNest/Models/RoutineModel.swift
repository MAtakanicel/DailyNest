

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
}
