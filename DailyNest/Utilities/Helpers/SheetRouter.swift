//
//  SheetRouter.swift
//  DailyNest
//
//  Created by Atakan on 18.03.2026.
//

import Foundation
import Observation

enum AppSheet: Identifiable, Equatable {
    case taskDetail(DailyTask)
    case routineDetail(Routine)

    case newDaily
    case newRoutine

    var id: String {
        switch self {
        case let .taskDetail(task): return "\(task.title)"
        case let .routineDetail(routine): return "\(routine.title)"
        case .newDaily: return "create new Daily Task"
        case .newRoutine: return "create new Routine"
        }
    }

    var task: DailyTask? {
        if case let .taskDetail(task) = self {
            return task
        }
        return nil
    }

    var routine: Routine? {
        if case let .routineDetail(routine) = self {
            return routine
        }
        return nil
    }
}

@Observable
class SheetRouter {
    var activeSheet: AppSheet?
}
