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
    var alertMessage: String? = nil
    
    func createDaily(
        title: String,
        details: String? = nil,
        date: Date = .now,
        priority: TaskPriority = .medium,
        isReminderOn: Bool = false,
        reminderDate: Date? = nil,
        context: ModelContext
    ) {
        let task = DailyTask(
            title: title,
            details: details,
            date: date,
            priority: priority,
            isReminderOn: isReminderOn,
            reminderDate: reminderDate
        )

        context.insert(task)
        
       updateDaily(task, context: context,method: "Create")
    }

   
    func deleteDaily(_ task: DailyTask, context: ModelContext) {
        context.delete(task)
        
        updateDaily(task, context: context,method: "Delete")
    }

    
    func updateDaily(_ task: DailyTask, context: ModelContext,method: String = "update")  {
        do {
            try context.save()
            print("Daily işlemi başarılı. (\(method)) Task: \(task.title)")
           
        } catch {
            print("Daily işlemi başarısız. (\(method)) Task:\(task.title) Hata: \(error.localizedDescription)")
            self.alertMessage = error.localizedDescription
            
        }
    }


    func toggleDailyCompletion(_ task: DailyTask, context: ModelContext)  {
        task.isCompleted.toggle()
        task.completedAt = task.isCompleted ? Date() : nil
        print("Task \(task.isCompleted ? "tamamlandı" : "geri alındı").")
        
        
        updateDaily(task, context: context,method: "Toggle")
    }
    
    func todaysDailys(_ dailys: [DailyTask]) -> [DailyTask] {
        return dailys.filter { !$0.isCompleted && Calendar.current.isDate($0.date, inSameDayAs: Date()) }
    }
    
    func overdueDailys(_ dailys: [DailyTask]) -> [DailyTask] {
        return dailys.filter { !$0.isCompleted && $0.date < Date() && !Calendar.current.isDate($0.date, inSameDayAs: Date()) }
    }
    
    func todayCompletedDailys(_ dailys: [DailyTask]) -> [DailyTask] {
        return dailys.filter { $0.isCompleted && Calendar.current.isDate($0.completedAt ?? Date(), inSameDayAs: Date()) }
    }
    
    func priorityFilter (_ dailys: [DailyTask],priority: TaskPriority) -> [DailyTask] {
        return dailys.filter{ $0.priority == priority }
    }
    
    func timeFilter (_ dailys: [DailyTask],filter : MatrixTimeFilter, date: Date = Date(), startDate: Date = Date(), endDate: Date = Date() ) -> [DailyTask] {
        switch filter{
        case .daily:
            return dailys.filter { Calendar.current.isDate($0.date, inSameDayAs: date)}
            
        case .weekly:
            let timeInterval = Calendar.current.dateInterval(of: .weekOfYear, for: date)
            guard let times = timeInterval else { return [] }
            return dailys.filter{ $0.date >= times.start && $0.date <= times.end  }
            
        case .monthly:
            let timeInterval = Calendar.current.dateInterval(of: .month, for: date)
            guard let times = timeInterval else { return [] }
            return dailys.filter{ $0.date >= times.start && $0.date <= times.end  }
       
        case .custom:
            let timeInterval = (startDate )...(endDate)
            return dailys.filter { timeInterval.contains($0.date) }
        }
    }
    
    func activeDailys(_ dailys: [DailyTask]) -> [DailyTask] {
        return dailys.filter{ !$0.isCompleted }
    }
}
