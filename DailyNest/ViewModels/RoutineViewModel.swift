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
    ) {
        let routine = RoutineTask(
            title: title,
            details: details,
            routineDays: routineDays,
            isReminderOn: isReminderOn,
            reminderTime: reminderTime
        )

        context.insert(routine)

        updateRoutine(routine, context: context,method: "create")
    }

    func deleteRoutine(_ routine: RoutineTask, context: ModelContext) {
        context.delete(routine)
        
        updateRoutine(routine, context: context,method: "Delete")
    }
    
   
    func updateRoutine(_ routine: RoutineTask, context: ModelContext,method : String = "update") {
        do {
            try context.save()
            print("Routine işlemi başarılı. (\(method)) Routine: \(routine.title)")
            
        } catch {
            print("Routine işlemi başarısız. (\(method)) Routine: \(routine.title)  Hata: \(error.localizedDescription)")
            self.alertMessage = error.localizedDescription
           
        }
    }

    
    func toggleRoutineCompletion(_ routine: RoutineTask, context: ModelContext) {
        let today = routine.completionHistory.first(where: { Calendar.current.isDateInToday($0.date) })
        
        if let completion = today {
            if completion.todaysCompletionCount < routine.maxCount {
                completion.todaysCompletionCount += 1
                print("routine: \(routine.title), count + 1")
            }
        } else {
            let newDailyLog = DailyLog(date: Date(), todaysCompletionCount: 1)
            routine.completionHistory.append(newDailyLog)
            print("\(routine.title) yeni günlük kayıt oluşturuldu.")
        }
         updateRoutine(routine, context: context,method: "toggleRoutineCompletion")
    }
    
    func todaysRoutineCompletionCount(_ routine: RoutineTask) -> Int {
        let today = routine.completionHistory.first(where: { Calendar.current.isDateInToday($0.date) })
        return today?.todaysCompletionCount ?? 0
    }
    
    func todaysRoutines(_ routines: [RoutineTask]) -> [RoutineTask] {
        let todayIndex = Calendar.current.component(.weekday, from: Date())
        guard let today = WeekDay(rawValue: todayIndex) else { return [] }
        return routines.filter { $0.routineDays.contains(today) && !$0.isCompletedToday }
    }
}
