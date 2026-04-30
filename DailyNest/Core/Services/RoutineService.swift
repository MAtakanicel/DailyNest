//
//  RoutineService.swift
//  DailyNest
//

import Foundation
import Observation

@Observable @MainActor
final class RoutineService {
    private let repository: RoutineRepositoryProtocol

    init(repository: RoutineRepositoryProtocol) {
        self.repository = repository
    }

    // MARK: - Validation
    func isValid(title: String) -> Bool {
        !title.trimmingCharacters(in: .whitespaces).isEmpty
    }

    // MARK: - CRUD
    func create(_ routine: Routine) throws {
        guard isValid(title: routine.title) else { return }
        try repository.create(routine)
    }

    func update(_ routine: Routine) throws {
        guard isValid(title: routine.title) else { return }
        try repository.update(routine)
    }

    func delete(_ routine: Routine) throws {
        try repository.delete(routine)
    }

    func toggleCompletion(_ routine: Routine) throws {
        let today = routine.dailyLog.first(where: { Calendar.current.isDateInToday($0.date) })
        if let completion = today {
            if completion.todaysCompletionCount < routine.routineGoal.targetCount {
                completion.todaysCompletionCount += 1
            }
        } else {
            routine.dailyLog.append(RoutineDailyLog(date: Date(), todaysCompletionCount: 1))
        }
        try repository.update(routine)
    }

    func resetCompletionToday(_ routine: Routine) throws {
        routine.dailyLog.first(where: { Calendar.current.isDateInToday($0.date) })?.todaysCompletionCount = 0
        try repository.update(routine)
    }

    func toggleDay(_ routine: Routine, day: WeekDay, selected: Bool) {
        if selected {
            routine.routineGoal.routineDays.append(day)
        } else {
            routine.routineGoal.routineDays.removeAll { $0 == day }
        }
    }

    // MARK: - Queries
    func todaysCount(_ routine: Routine) -> Int {
        routine.dailyLog.first(where: { Calendar.current.isDateInToday($0.date) })?.todaysCompletionCount ?? 0
    }

    func completionSeries(_ routine: Routine) -> Int {
        var count = 0
        var currentDate = routine.isCompletedToday
            ? Date()
            : Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()
        let history = routine.dailyLog
        while true {
            let dayIndex = Calendar.current.component(.weekday, from: currentDate)
            guard let weekDay = WeekDay(rawValue: dayIndex) else { return count }
            if routine.routineGoal.routineDays.contains(weekDay) {
                let met = history.contains(where: {
                    Calendar.current.isDate($0.date, inSameDayAs: currentDate) &&
                    $0.todaysCompletionCount >= routine.routineGoal.targetCount
                })
                if met {
                    count += 1
                    currentDate = Calendar.current.date(byAdding: .day, value: -1, to: currentDate) ?? currentDate
                } else {
                    return count
                }
            } else {
                currentDate = Calendar.current.date(byAdding: .day, value: -1, to: currentDate) ?? currentDate
            }
        }
    }

    // MARK: - Filters
    func todaysRoutines(_ routines: [Routine]) -> [Routine] {
        let todayIndex = Calendar.current.component(.weekday, from: Date())
        guard let today = WeekDay(rawValue: todayIndex) else { return [] }
        return routines.filter { $0.routineGoal.routineDays.contains(today) }
    }

    func calendarFilter(_ routines: [Routine], selectDay: Date, filter: TaskFilter) -> [Routine] {
        let dayIndex = Calendar.current.component(.weekday, from: selectDay)
        guard let weekDay = WeekDay(rawValue: dayIndex) else { return [] }
        let dayFiltered = routines.filter { $0.routineGoal.routineDays.contains(weekDay) }
        if filter == .all { return dayFiltered }
        return dayFiltered.filter { !$0.isCompletedToday }
    }

    func sortedByPriority(_ routines: [Routine]) -> [Routine] {
        routines.sorted { $0.priority.rawValue < $1.priority.rawValue }
    }

    func filtered(_ routines: [Routine], searchText: String, filter: TaskFilter) -> [Routine] {
        let searched = routines.filter {
            searchText.isEmpty ? true : $0.title.localizedCaseInsensitiveContains(searchText)
        }
        switch filter {
        case .active: return searched.filter { !$0.isCompletedToday }
        case .all: return searched
        }
    }

    func displayed(
        _ routines: [Routine],
        searchText: String,
        selectedDate: Date,
        filter: TaskFilter
    ) -> [Routine] {
        let calFiltered = calendarFilter(routines, selectDay: selectedDate, filter: filter)
        let sorted = sortedByPriority(calFiltered)
        return filtered(sorted, searchText: searchText, filter: filter)
    }
}
