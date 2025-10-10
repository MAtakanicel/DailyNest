import Foundation

final class ToDoViewModel : ObservableObject {
    @Published var todos  = MockData.mockData

    var sortedTodos : [ToDo] {
        todos.sorted { a, b in
            if a.isRoutine != b.isRoutine {
                return a.isRoutine && !b.isRoutine
            }else{
                return !a.isDone && b.isDone
            }
        }
    }
    
    var activeTodos : [ToDo] {
        sortedTodos.filter{ !$0.isDone }
    }
    
    var completedTodos : [ToDo] {
        sortedTodos.filter{ $0.isDone }
    }
    
    var sortedActiveTodos : [ToDo] {
        activeTodos.sorted { a, b in
            if a.isRoutine != b.isRoutine {
                return a.isRoutine && !b.isRoutine
            }else {
                return !a.isDone && b.isDone
            }
        }
    }
    
    
}
