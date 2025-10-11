import Foundation

final class ToDoViewModel : ObservableObject {
    @Published var todos  = MockData.mockData
   
    var sortedTodos : [ToDo] {
        todos.sorted { a, b in
            if a.isRoutine != b.isRoutine {
                return a.isRoutine && !b.isRoutine
            }else{
                return !a.isCompleted && b.isCompleted
            }
        }
    }

    var routineTodos : [ToDo] {
        sortedTodos.filter{ $0.isRoutine }
    }
    
    var dailyTodos : [ToDo] {
        sortedTodos.filter{ !$0.isRoutine }
    }
    
    var activeDailyTodos : [ToDo] {
        dailyTodos.filter{ !$0.isCompleted }
    }
    
    var activeRoutineTodos : [ToDo] {
        routineTodos.filter{ !$0.isCompleted }
    }
    

   
    
    var mainPageToDos : [ToDo] {
        sortedTodos.filter{ !$0.isCompleted }
    }
    
    var completedTodos : [ToDo] {
        sortedTodos.filter{ $0.isCompleted }
    }

}
