//
//  RoutineTaskViewModel.swift
//  DailyNest
//
//  Created by Atakan on 10.03.2026.
//

import Foundation
import SwiftData
import Combine

final class RoutineViewModel: ObservableObject {
    
    func createRoutine(
        title: String,
        details: String? = nil,
        routineDays: [WeekDay],
        isReminderOn: Bool = false,
        reminderTime: Date? = nil,
        context : ModelContext
    ) -> Result<Bool,Error>{
        
        let routine = RoutineTask(
            title: title,
            details: details,
            routineDays: routineDays,
            isReminderOn: isReminderOn,
            reminderTime: reminderTime
    )
        
        context.insert(routine)
        
        do{
            try context.save()
            return .success(true)
        } catch {
            return .failure(error)
        }
    }
    
    func deleteRoutine(_ task : RoutineTask, context : ModelContext) -> Result<Bool,Error>{
        context.delete(task)
        
        do{
            try context.save()
            return .success(true)
        } catch {
            return .failure(error)
        }
    }
    
    func updateRoutine(_ task : RoutineTask, context : ModelContext) -> Result<Bool,Error>{
        do{
            try context.save()
            return .success(true)
        } catch {
            return .failure(error)
        }
    }
    
    func toggleRoutineCompletion(_ task : RoutineTask, context : ModelContext) -> Result<Bool,Error>{
        
        if task.isCompletedToday {
            task.completionHistory.removeAll { Calendar.current.isDateInToday($0)}
        } else {
            task.completionHistory.append(Date())
        }
        
        return updateRoutine(task, context: context)
    }
}
