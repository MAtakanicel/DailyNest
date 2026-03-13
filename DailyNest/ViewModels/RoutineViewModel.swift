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
    var alertMessage: String? = nil
    
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
            print("Routine güncellendi.")
            return .success(true)
        } catch {
            return .failure(error)
        }
    }

    func toggleRoutineCompletion(_ task: RoutineTask, context: ModelContext){
        let today = task.completionHistory.first(where: {Calendar.current.isDateInToday($0.date) })
        
        if let completion = today{
            if completion.todaysCompletionCount < task.maxCount {
                completion.todaysCompletionCount += 1
            }
        } else {
            let newDailyLog = DailyLog(date: Date(), todaysCompletionCount: 1)
            task.completionHistory.append(newDailyLog)
            
        }
        do {
            try context.save()
        }catch{
            print("Routine toggle hatası: \(error.localizedDescription)")
        }
        
    }
    
    func todaysRoutines(routines: [RoutineTask]) -> [RoutineTask] {
        let todayIndex = Calendar.current.component(.weekday, from: Date())
        guard let today = WeekDay(rawValue: todayIndex) else { return [] }
        return routines.filter { $0.routineDays.contains(today) }
    }
}
