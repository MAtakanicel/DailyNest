
import Foundation

struct Data{
    static let mockRoutines: [Routine] = [
        Routine(id: UUID(), description: nil, isReminder: true, title: "Ev İşi", createdAt: Date(), routineDays: [.friday], isCompletedToday: true, reminderTime: nil),
        Routine(id: UUID(), description: nil, isReminder: false, title: "Sabah yürüyüşü", createdAt: Date(), routineDays: [.saturday,.wednesday], isCompletedToday: false, reminderTime: nil),
        Routine(id: UUID(), description: "ACil", isReminder: false, title: "İlaç", createdAt: Date(), routineDays: WeekDay.allCases, isCompletedToday: false, reminderTime: nil),
        Routine(id: UUID(), description: "Deneme", isReminder: true, title: "Deneme", createdAt: Date(), routineDays: [.thursday,.sunday], isCompletedToday: true, reminderTime: nil),
        Routine(id: UUID(), description: <#T##String?#>, isReminder: <#T##Bool#>, title: <#T##String#>, createdAt: <#T##Date#>, routineDays: <#T##[WeekDay]#>, isCompletedToday: <#T##Bool#>, reminderTime: <#T##Date?#>),
        Routine(id: UUID(), description: <#T##String?#>, isReminder: <#T##Bool#>, title: <#T##String#>, createdAt: <#T##Date#>, routineDays: <#T##[WeekDay]#>, isCompletedToday: <#T##Bool#>, reminderTime: <#T##Date?#>),
        Routine(id: UUID(), description: <#T##String?#>, isReminder: <#T##Bool#>, title: <#T##String#>, createdAt: <#T##Date#>, routineDays: <#T##[WeekDay]#>, isCompletedToday: <#T##Bool#>, reminderTime: <#T##Date?#>),
        Routine(id: UUID(), description: <#T##String?#>, isReminder: <#T##Bool#>, title: <#T##String#>, createdAt: <#T##Date#>, routineDays: <#T##[WeekDay]#>, isCompletedToday: <#T##Bool#>, reminderTime: <#T##Date?#>),
    ]
    
    
    static let mockTasks : [Task] = [
        Task(id: UUID(), description: "Deneme2", isReminder: true, title: "Deno", createdAt: Date(), date: nil, isCompleted: false, completedAt: nil, priority: nil, reminderDate: nil),
        Task(id: UUID(), description: "DenemeTo", isReminder: false, title: "DemeTo", createdAt: Date(), date: nil, isCompleted: true, completedAt: nil, priority: .high, reminderDate: nil),
        Task(id: UUID(), description: <#T##String?#>, isReminder: <#T##Bool#>, title: <#T##String#>, createdAt: <#T##Date#>, date: <#T##Date?#>, isCompleted: <#T##Bool#>, completedAt: <#T##Date?#>, priority: <#T##ToDoPriority?#>, reminderDate: <#T##Date?#>),
        Task(id: UUID(), description: <#T##String?#>, isReminder: <#T##Bool#>, title: <#T##String#>, createdAt: <#T##Date#>, date: <#T##Date?#>, isCompleted: <#T##Bool#>, completedAt: <#T##Date?#>, priority: <#T##ToDoPriority?#>, reminderDate: <#T##Date?#>),
        Task(id: UUID(), description: <#T##String?#>, isReminder: <#T##Bool#>, title: <#T##String#>, createdAt: <#T##Date#>, date: <#T##Date?#>, isCompleted: <#T##Bool#>, completedAt: <#T##Date?#>, priority: <#T##ToDoPriority?#>, reminderDate: <#T##Date?#>),
        Task(id: UUID(), description: <#T##String?#>, isReminder: <#T##Bool#>, title: <#T##String#>, createdAt: <#T##Date#>, date: <#T##Date?#>, isCompleted: <#T##Bool#>, completedAt: <#T##Date?#>, priority: <#T##ToDoPriority?#>, reminderDate: <#T##Date?#>),
        Task(id: UUID(), description: <#T##String?#>, isReminder: <#T##Bool#>, title: <#T##String#>, createdAt: <#T##Date#>, date: <#T##Date?#>, isCompleted: <#T##Bool#>, completedAt: <#T##Date?#>, priority: <#T##ToDoPriority?#>, reminderDate: <#T##Date?#>),
        Task(id: UUID(), description: <#T##String?#>, isReminder: <#T##Bool#>, title: <#T##String#>, createdAt: <#T##Date#>, date: <#T##Date?#>, isCompleted: <#T##Bool#>, completedAt: <#T##Date?#>, priority: <#T##ToDoPriority?#>, reminderDate: <#T##Date?#>),
    ]
    
}
