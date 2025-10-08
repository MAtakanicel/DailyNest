

import Foundation

struct ToDo : Identifiable, Hashable{
    
    let id = UUID()
    let title : String
    var isDone : Bool
    let isRoutine : Bool
    
}

struct tempToDos {
    public let todos = [
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
       ToDo(title: "Rutin1", isDone: false, isRoutine: true),
       ToDo(title: "Rutin2", isDone: false, isRoutine: true),
       ToDo(title: "Rutin3", isDone: false, isRoutine: true),
       ToDo(title: "Rutin4", isDone: false, isRoutine: true)
   ]
}

