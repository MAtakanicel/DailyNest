//
//  DailyTaskService.swift
//  DailyNest
//

import Foundation


@Observable @MainActor
final class DailyTaskService {
    private let repository: DailyTaskRepositoryProtocol

    init(repository: DailyTaskRepositoryProtocol) {
        self.repository = repository
    }

    // MARK: - Validation
    func isValid(title: String) -> Bool {
        !title.trimmingCharacters(in: .whitespaces).isEmpty
    }

    // MARK: - CRUD
    func create(_ task: DailyTask) throws {
        guard isValid(title: task.title) else { return }
        task.date = Calendar.current.startOfDay(for: task.date)
        try repository.create(task)
    }

    func update(_ task: DailyTask) throws {
        guard isValid(title: task.title) else { return }
        task.date = Calendar.current.startOfDay(for: task.date)
        try repository.update(task)
    }

    func delete(_ task: DailyTask) throws {
        try repository.delete(task)
    }

    func toggleCompletion(_ task: DailyTask) throws {
        task.isCompleted.toggle()
        task.completedAt = task.isCompleted ? Date() : nil
        try repository.update(task)
    }

    // MARK: - Filters
    func dailysForDate(_ tasks: [DailyTask], date: Date) -> [DailyTask] {
        tasks.filter { Calendar.current.isDate($0.date, inSameDayAs: date) }
    }

    func todays(_ tasks: [DailyTask]) -> [DailyTask] {
        tasks.filter { Calendar.current.isDate($0.date, inSameDayAs: Date()) }
    }

    func todaysActive(_ tasks: [DailyTask]) -> [DailyTask] {
        tasks.filter { !$0.isCompleted && Calendar.current.isDate($0.date, inSameDayAs: Date()) }
    }

    func overdue(_ tasks: [DailyTask]) -> [DailyTask] {
        tasks.filter {
            !$0.isCompleted &&
            $0.date < Date() &&
            !Calendar.current.isDate($0.date, inSameDayAs: Date())
        }
    }

    func todayCompleted(_ tasks: [DailyTask]) -> [DailyTask] {
        tasks.filter {
            $0.isCompleted &&
            Calendar.current.isDate($0.completedAt ?? Date(), inSameDayAs: Date())
        }
    }

    func active(_ tasks: [DailyTask]) -> [DailyTask] {
        tasks.filter { !$0.isCompleted }
    }

    func priorityFilter(_ tasks: [DailyTask], priority: TaskPriority) -> [DailyTask] {
        tasks.filter { $0.priority == priority }
    }

    func timeFilter(
        _ tasks: [DailyTask],
        filter: MatrixTimeFilter,
        date: Date = Date(),
        startDate: Date = Date(),
        endDate: Date = Date()
    ) -> [DailyTask] {
        switch filter {
        case .daily:
            return tasks.filter { Calendar.current.isDate($0.date, inSameDayAs: date) }
        case .weekly:
            guard let interval = Calendar.current.dateInterval(of: .weekOfYear, for: date) else { return [] }
            return tasks.filter { $0.date >= interval.start && $0.date <= interval.end }
        case .monthly:
            guard let interval = Calendar.current.dateInterval(of: .month, for: date) else { return [] }
            return tasks.filter { $0.date >= interval.start && $0.date <= interval.end }
        case .custom:
            return tasks.filter { (startDate...endDate).contains($0.date) }
        }
    }

    func quadrant(
        from tasks: [DailyTask],
        priority: TaskPriority,
        showCompleted: Bool,
        timeFilter filter: MatrixTimeFilter,
        date: Date,
        startDate: Date,
        endDate: Date
    ) -> [DailyTask] {
        let filtered = showCompleted ? tasks : active(tasks)
        let timePassed = timeFilter(filtered, filter: filter, date: date, startDate: startDate, endDate: endDate)
        return priorityFilter(timePassed, priority: priority)
    }
}
