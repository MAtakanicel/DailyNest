import Combine
import Foundation



@MainActor
final class TaskViewModel : ObservableObject{
    @Published var tasks: [Task] = []
    
    init() {
        loadTasks()
    }
    
    func loadTasks() {
        tasks = Data.mockTasks
    }
    
    func saveTasks() async{
        // Veri tabanı kaydı
    }
    
    func removeTask(at indexSet: IndexSet) async{
        tasks.remove(atOffsets: indexSet)
        await saveTasks()
    }
    
    
    func addTask(_ task : Task) async{
        let newTask = Task(
            id: UUID(),
            description: <#T##String?#>,
            isReminder: <#T##Bool#>,
            title: <#T##String#>,
            createdAt: <#T##Date#>,
            date: <#T##Date?#>,
            isCompleted: <#T##Bool#>,
            completedAt: <#T##Date?#>,
            priority: <#T##ToDoPriority?#>,
            reminderDate: <#T##Date?#>
        )
        tasks.append(newTask)
        await saveTasks()
    }
    
    
    
    
    
    // Tamamlama fonksiyonu eklenecek
    // Bildirim eklenecek
}
