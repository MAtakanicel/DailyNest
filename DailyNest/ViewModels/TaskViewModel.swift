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
            description: task.description,
            isReminder: task.isReminder,
            title: task.title,
            createdAt: task.createdAt,
            date: task.date,
            isCompleted: task.isCompleted,
            completedAt: task.completedAt,
            priority: task.priority,
            reminderDate: task.completedAt
        )
        tasks.append(newTask)
        await saveTasks()
    }
    
    func toggleIsCompleted(for task: Task) async{
        guard let index = tasks.firstIndex(of: task) else { return }
        tasks[index].isCompleted.toggle()
        await saveTasks()
    }
    
    
    
    // Tamamlama fonksiyonu eklenecek
    // Bildirim eklenecek
}
