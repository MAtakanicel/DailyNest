

import Foundation

struct ToDo : Identifiable{
    
    let id = UUID()
    let title : String
    let isDone : Bool
    
}

struct RoutineToDo : Identifiable{
    
    let id = UUID()
    let title : String
    let isDone : Bool
    
}
