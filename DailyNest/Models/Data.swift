
import Foundation

struct Data{
    static let mockRoutines: [Routine] = [
        Routine(id: UUID(), description: nil, isReminder: true, title: "Ev İşi", createdAt: Date(), routineDays: [.friday], isCompletedToday: true, reminderTime: nil),
        Routine(id: UUID(), description: nil, isReminder: false, title: "Sabah yürüyüşü", createdAt: Date(), routineDays: [.saturday,.wednesday], isCompletedToday: false, reminderTime: nil),
        Routine(id: UUID(), description: "ACil", isReminder: false, title: "İlaç", createdAt: Date(), routineDays: WeekDay.allCases, isCompletedToday: false, reminderTime: nil),
        Routine(id: UUID(), description: "Deneme", isReminder: true, title: "Deneme", createdAt: Date(), routineDays: [.thursday,.sunday], isCompletedToday: true, reminderTime: nil),
    ]
    
    
    static let mockTasks : [Task] = [
        Task(id: UUID(), description: "Deneme2", isReminder: true, title: "Deno", createdAt: Date(), date: nil, isCompleted: false, completedAt: nil, priority: nil, reminderDate: nil),
    ]
    
}
