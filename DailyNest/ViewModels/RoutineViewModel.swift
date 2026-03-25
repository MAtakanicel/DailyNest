//
//  RoutineViewModel.swift
//  DailyNest
//
//  Created by Atakan on 10.03.2026.
//

import Foundation
import Observation
import SwiftData

@Observable @MainActor
final class RoutineViewModel {
    var alertMessage: String?

    func newRoutineValid(title: String) -> Bool {
        !title.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    func createRoutine(
        title: String,
        details: String? = nil,
        routineDays: [WeekDay],
        isReminderOn: Bool = false,
        reminderTime: Date? = nil,
        context: ModelContext
    ) {
        let routine = Routine(
            title: title,
            details: details,
            routineDays: routineDays,
            isReminderOn: isReminderOn,
            reminderTime: reminderTime
        )

        context.insert(routine)

        updateRoutine(routine, context: context, method: "create")
    }

    func deleteRoutine(_ routine: Routine, context: ModelContext) {
        context.delete(routine)

        updateRoutine(routine, context: context, method: "Delete")
    }

    func updateRoutine(_ routine: Routine, context: ModelContext, method: String = "update") {
        do {
            try context.save()
            print("Routine işlemi başarılı. (\(method)) Routine: \(routine.title)")

        } catch {
            print("Routine işlemi başarısız. (\(method)) Routine: \(routine.title)  Hata: \(error.localizedDescription)")
            alertMessage = error.localizedDescription
        }
    }

    func toggleRoutineCompletion(_ routine: Routine, context: ModelContext) {
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
        updateRoutine(routine, context: context, method: "toggleRoutineCompletion")
    }
    
    func filteredRoutines(_ routines: [Routine],searchText: String, selectFilter : TaskFilter ) -> [Routine] {
        let searchFiltred = routines.filter { task in
            searchText.isEmpty ? true : task.title.localizedCaseInsensitiveContains(searchText)
        }
        
        switch selectFilter {
        case .active:
            return searchFiltred.filter { !$0.isCompletedToday }
        case .all:
            return searchFiltred
        }
    }

    /// Günlük ilerleme reset
    func routineCompetionResetToday(_ routine: Routine, context: ModelContext) {
        let today = routine.completionHistory.first(where: { Calendar.current.isDateInToday($0.date) })
        today?.todaysCompletionCount = 0

        updateRoutine(routine, context: context, method: "routineCompetionReset")
    }

    func todaysRoutineCompletionCount(_ routine: Routine) -> Int {
        let today = routine.completionHistory.first(where: { Calendar.current.isDateInToday($0.date) })
        return today?.todaysCompletionCount ?? 0
    }

    func todaysRoutines(_ routines: [Routine]) -> [Routine] {
        let todayIndex = Calendar.current.component(.weekday, from: Date())
        guard let today = WeekDay(rawValue: todayIndex) else { return [] }
        return routines.filter { $0.routineDays.contains(today) }
    }

    func routineSortedByPriority(_ routines: [Routine]) -> [Routine] {
        return routines.sorted { $0.priority.rawValue < $1.priority.rawValue }
    }

    /// haftanın günlerine göre filtreli routine
    func calendarFilterRoutine(_ routines: [Routine], selectDay: Date, isActive: TaskFilter) -> [Routine] {
        let todayIndex = Calendar.current.component(.weekday, from: selectDay)
        guard let today = WeekDay(rawValue: todayIndex) else { return [] }

        if isActive == .all {
            return routines.filter { $0.routineDays.contains(today) }
        } else {
            return routines.filter { $0.routineDays.contains(today) && !$0.isCompletedToday }
        }
    }

    /// Tamamlama serisi
    func routineCompletionSeries(_ routine: Routine) -> Int {
        var count = 0
        var currentDate = routine.isCompletedToday ? Date() : Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        let list = routine.completionHistory
        while true {
            let todayIndex = WeekDay(rawValue: Calendar.current.component(.weekday, from: currentDate))
            guard let today = todayIndex else { return 0 }
            if routine.routineDays.contains(today) {
                if list.contains(where: { Calendar.current.isDate($0.date, inSameDayAs: currentDate)
                        && ($0.todaysCompletionCount >= routine.maxCount)
                }) {
                    count += 1
                    currentDate = Calendar.current.date(byAdding: .day, value: -1, to: currentDate)!
                } else {
                    return count
                }
            } else {
                currentDate = Calendar.current.date(byAdding: .day, value: -1, to: currentDate)!
            }
        }
    }
}
