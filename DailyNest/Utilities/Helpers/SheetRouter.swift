//
//  SheetRouter.swift
//  DailyNest
//
//  Created by Atakan on 18.03.2026.
//

import Foundation
import Observation

enum AppSheet: Identifiable{
    case taskDetail(DailyTask)
    case routineDetail(RoutineTask)
    
    case newDaily
    case newRoutine
    
    var id : String{
        switch self{
        case .taskDetail(let task):                 return "task_\(task.id)"
        case .routineDetail(let routine):           return "routine_\(routine.id)"
        case .newDaily:                             return "newDaily"
        case .newRoutine:                           return "newRoutine"
        }
    }
}

@Observable
class SheetRouter{
    var activeSheet: AppSheet? = nil
}
