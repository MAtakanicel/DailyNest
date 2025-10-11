

import Foundation

struct ToDo : Identifiable, Hashable{
    
    let id = UUID()
    let title : String
    var isCompleted : Bool
    let isRoutine : Bool
    
}


