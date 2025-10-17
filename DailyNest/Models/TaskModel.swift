
import Foundation

enum ToDoPriority: String,Codable,CaseIterable{
    case high, medium, low
}

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
    }
