import Foundation

final class ToDoViewModel : ObservableObject {
    @Published var todos  = MockData.mockData

    var routineTodos : [ToDo] {
        todos.filter{ $0.isRoutine }
    }
    
    var dailyTodos : [ToDo] {
        todos.filter{ !$0.isRoutine }
    }
    
    var activeDailyTodos : [ToDo] {
        dailyTodos.filter{ !$0.isCompleted }
    }
    
    var activeRoutineTodos : [ToDo] {
        routineTodos.filter{ !$0.isCompleted }
    }
    
    var sortedTodos : [ToDo] {
        todos.sorted { a, b in
            if a.isRoutine != b.isRoutine {
                return a.isRoutine && !b.isRoutine
            }else{
                return !a.isCompleted && b.isCompleted
            }
        }
    }
    
    var activeTodos : [ToDo] {
        sortedTodos.filter{ !$0.isCompleted }
    }
    
    var completedTodos : [ToDo] {
        sortedTodos.filter{ $0.isCompleted }
    }
    
    //Rutinler başta, son eklenen üstte ve sadec aktifler
    var sortedActiveTodos : [ToDo] {
        activeTodos.sorted { a, b in
            if a.isRoutine != b.isRoutine {
                return a.isRoutine && !b.isRoutine
            }else {
                return !a.isCompleted && b.isCompleted
            }
        }
    }
    
    
    
}
