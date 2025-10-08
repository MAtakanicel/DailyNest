

import Foundation

struct ToDo : Identifiable, Hashable{
    
    let id = UUID()
    let title : String
    var isDone : Bool
    let isRoutine : Bool
    
}

struct tempToDos {
}

