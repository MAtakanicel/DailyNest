import Foundation

final class ToDoViewModel : ObservableObject {
    @Published var todos : [ToDo] = [
        ToDo(title: "SwiftUI", isDone: false, isRoutine: false),
        ToDo(title: "Combine", isDone: true, isRoutine: false),
        ToDo(title: "Rutin1", isDone: false, isRoutine: true),
        ToDo(title: "Rutin2", isDone: false, isRoutine: true),
        ToDo(title: "Rutin3", isDone: false, isRoutine: true),
        ToDo(title: "Rutin4", isDone: false, isRoutine: true),
        ToDo(title: "SwiftUI", isDone: false, isRoutine: false),
        ToDo(title: "Combine", isDone: true, isRoutine: false),
        ToDo(title: "Rutin1", isDone: false, isRoutine: true),
        ToDo(title: "Rutin2", isDone: false, isRoutine: true),
        ToDo(title: "Rutin3", isDone: false, isRoutine: true),
        ToDo(title: "Rutin4", isDone: false, isRoutine: true),
        ToDo(title: "SwiftUI", isDone: false, isRoutine: false),
        ToDo(title: "Combine", isDone: true, isRoutine: false),
    ]

    var sortedTodos : [ToDo] {
        todos.sorted { a, b in
            if a.isRoutine != b.isRoutine {
                return a.isRoutine && !b.isRoutine
            }else{
                return !a.isDone && b.isDone
            }
        }
    }
    
    
}
