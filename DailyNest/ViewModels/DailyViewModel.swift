//
//  DailyViewModel.swift
//  DailyNest
//
//  Created by Atakan on 10.03.2026.
//

import Observation
import Foundation
import SwiftData

@Observable @MainActor
final class DailyViewModel {
    func createDaily(
        title: String,
        details: String? = nil,
        date: Date = .now,
        priority: TaskPriority = .medium,
        isReminderOn: Bool = false,
        reminderDate: Date? = nil,
        context: ModelContext
    ) -> Result<Bool, Error> {
        let task = DailyTask(
            title: title,
            details: details,
            date: date,
            priority: priority,
            isReminderOn: isReminderOn,
            reminderDate: reminderDate
        )

        context.insert(task)
        do {
            try context.save()
            return .success(true)
        } catch {
            return .failure(error)
        }
    }

    func deleteDaily(_ task: DailyTask, context: ModelContext) -> Result<Bool, Error> {
        context.delete(task)
        do {
            try context.save()
            return .success(true)
        } catch {
            return .failure(error)
        }
    }

    func updateDaily(_: DailyTask, context: ModelContext) -> Result<Bool, Error> {
        do {
            try context.save()
            return .success(true)
        } catch {
            return .failure(error)
        }
    }

    func toggleDailyCompletion(_ task: DailyTask, context: ModelContext) -> Result<Bool, Error> {
        task.isCompleted.toggle()
        task.completedAt = task.isCompleted ? Date() : nil

        return updateDaily(task, context: context)
    }
    
    func todaysDailys(_ dailys: [DailyTask]) -> [DailyTask] {
        return dailys.filter { Calendar.current.isDate($0.date, inSameDayAs: Date()) }
    }
    
    func overdueDailys(_ dailys: [DailyTask]) -> [DailyTask] {
        return dailys.filter{ $0.date < Date() && !Calendar.current.isDate($0.date, inSameDayAs: Date())  }
    }
}
