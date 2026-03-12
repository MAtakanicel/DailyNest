//
//  RoutineViewModel.swift
//  DailyNest
//
//  Created by Atakan on 10.03.2026.
//

import Observation
import Foundation
import SwiftData

@Observable @MainActor
final class RoutineViewModel {
    func createRoutine(
        title: String,
        details: String? = nil,
        routineDays: [WeekDay],
        isReminderOn: Bool = false,
        reminderTime: Date? = nil,
        context: ModelContext
    ) -> Result<Bool, Error> {
        let routine = RoutineTask(
            title: title,
            details: details,
            routineDays: routineDays,
            isReminderOn: isReminderOn,
            reminderTime: reminderTime
        )

        context.insert(routine)

        do {
            try context.save()
            return .success(true)
        } catch {
            return .failure(error)
        }
    }

    func deleteRoutine(_ task: RoutineTask, context: ModelContext) -> Result<Bool, Error> {
        context.delete(task)

        do {
            try context.save()
            return .success(true)
        } catch {
            return .failure(error)
        }
    }

    func updateRoutine(_: RoutineTask, context: ModelContext) -> Result<Bool, Error> {
        do {
            try context.save()
            return .success(true)
        } catch {
            return .failure(error)
        }
    }

    func toggleRoutineCompletion(_ task: RoutineTask, context: ModelContext) -> Result<Bool, Error> {
        if task.isCompletedToday {
            task.completionHistory.removeAll { Calendar.current.isDateInToday($0) }
        } else {
            task.completionHistory.append(Date())
        }

        return updateRoutine(task, context: context)
    }
    
    func todaysRoutines(routines: [RoutineTask]) -> [RoutineTask] {
        let todayIndex = Calendar.current.component(.weekday, from: Date())
        guard let today = WeekDay(rawValue: todayIndex) else { return [] }
        return routines.filter { $0.routineDays.contains(today) }
    }
}
