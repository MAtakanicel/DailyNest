//
//  TaskViewModel.swift
//  DailyNest
//
//  Created by Atakan on 10.03.2026.
//

import Foundation
import Combine
import SwiftData

final class DailyViewModel : ObservableObject {
    
    func createDaily(
        title: String,
        details: String? = nil,
        date:Date = .now,
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
        do{
            try context.save()
            return .success(true)
        }catch{
            return .failure(error)
        }
        
    }
    
    
    func deleteDaily(_ task : DailyTask, context : ModelContext) -> Result<Bool, Error> {
        context.delete(task)
        do{
            try context.save()
            return .success(true)
        }catch {
            return .failure(error)
        }
    }
    
    func updateDaily(_ task : DailyTask, context: ModelContext) -> Result<Bool, Error> {
        do {
            try context.save()
            return .success(true)
        }catch {
            return .failure(error)
        }
    }
    
    func toggleDailyCompletion(_ task: DailyTask, context: ModelContext) -> Result<Bool, Error> {
        task.isCompleted.toggle()
        task.completedAt = task.isCompleted ? Date() : nil
        
        return updateDaily(task, context: context)
    }
    
    
}
