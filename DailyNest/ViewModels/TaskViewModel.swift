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
}
