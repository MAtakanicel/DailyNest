//
//  RoutineViewModel.swift
//  DailyNest
//
//  Created by Atakan on 10.03.2026.
//

import Foundation
import Observation

@Observable @MainActor
final class RoutineViewModel {
    let repository : RoutineRepositoryProtocol
    var alertMessage: String?
    
    func displayedRoutines(
        forRoutinesView tasks: [Routine],
        searchText: String,
        selectedDate: Date,
        selectFilter: TaskFilter
    ) -> [Routine] {
        let calendarFiltered = calendarFilterRoutine(tasks, selectDay: selectedDate, isActive: selectFilter)
        let sorted = routineSortedByPriority(calendarFiltered)
        return filteredRoutines(sorted, searchText: searchText, selectFilter: selectFilter)
    }

    init(repository: RoutineRepository) { self.repository = repository }
    
    func newRoutineValid(title: String) -> Bool {
        !title.trimmingCharacters(in: .whitespaces).isEmpty
    }

    func createRoutine(_ routine: Routine) {
        
        guard newRoutineValid(title: routine.title) else { return }

        do{
            try repository.create(routine)
        }catch{
            alertMessage  = error.localizedDescription
        }
    }
    
    func updateRoutine(_ routine: Routine){
        guard newRoutineValid(title: routine.title) else { return }
        
        do{
            try repository.update(routine)
        }catch{
            alertMessage = error.localizedDescription
        }
    }

    func deleteRoutine(_ routine: Routine ) {
        do{
            try repository.delete(routine)
        }catch{
            alertMessage = error.localizedDescription
        }
    }

    func toggleRoutineCompletion(_ routine: Routine) {
        let today = routine.completionHistory.first(where: { Calendar.current.isDateInToday($0.date) })

        if let completion = today {
            if completion.todaysCompletionCount < routine.routineGoal.targetCount {
                completion.todaysCompletionCount += 1
                print("routine: \(routine.title), count + 1")
            }
        } else {
            let newDailyLog = DailyLog(date: Date(), todaysCompletionCount: 1)
            routine.completionHistory.append(newDailyLog)
            print("\(routine.title) yeni günlük kayıt oluşturuldu.")
        }
        
        do{
            try repository.update(routine)
        }catch{
            alertMessage = error.localizedDescription
        }
    }
    
    func toggleRoutineDay(_ routine: Routine, day: WeekDay,_ selected: Bool){
        if selected{
            routine.routineGoal.routineDays.append(day)
        }else{
            routine.routineGoal.routineDays.removeAll { $0 == day }
        }
    }
    

    func filteredRoutines(_ routines: [Routine], searchText: String, selectFilter: TaskFilter) -> [Routine] {
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
    func routineCompetionResetToday(_ routine: Routine) {
        let today = routine.completionHistory.first(where: { Calendar.current.isDateInToday($0.date) })
        today?.todaysCompletionCount = 0

        do{
            try repository.update(routine)
        }catch{
            alertMessage = error.localizedDescription
        }
    }

    func todaysRoutineCompletionCount(_ routine: Routine) -> Int {
        let today = routine.completionHistory.first(where: { Calendar.current.isDateInToday($0.date) })
        return today?.todaysCompletionCount ?? 0
    }

    func todaysRoutines(_ routines: [Routine]) -> [Routine] {
        let todayIndex = Calendar.current.component(.weekday, from: Date())
        guard let today = WeekDay(rawValue: todayIndex) else { return [] }
        return routines.filter { $0.routineGoal.routineDays.contains(today) }
    }

    func routineSortedByPriority(_ routines: [Routine]) -> [Routine] {
        return routines.sorted { $0.priority.rawValue < $1.priority.rawValue }
    }

    /// haftanın günlerine göre filtreli routine
    func calendarFilterRoutine(_ routines: [Routine], selectDay: Date, isActive: TaskFilter) -> [Routine] {
        let todayIndex = Calendar.current.component(.weekday, from: selectDay)
        guard let today = WeekDay(rawValue: todayIndex) else { return [] }

        if isActive == .all {
            return routines.filter { $0.routineGoal.routineDays.contains(today) }
        } else {
            return routines.filter { $0.routineGoal.routineDays.contains(today) && !$0.isCompletedToday }
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
            if routine.routineGoal.routineDays.contains(today) {
                if list.contains(where: { Calendar.current.isDate($0.date, inSameDayAs: currentDate)
                    && ($0.todaysCompletionCount >= routine.routineGoal.targetCount)
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
