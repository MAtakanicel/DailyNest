//
//  DailyViewModel.swift
//  DailyNest
//
//  Created by Atakan on 10.03.2026.
//

import Foundation
import Observation

@Observable @MainActor
final class DailyViewModel {
    let repository: DailyTaskRepositoryProtocol
    var alertMessage: String?

    init(repository: DailyTaskRepository){ self.repository = repository }
    
    func newDailyValid(title: String) -> Bool {
        !title.trimmingCharacters(in: .whitespaces).isEmpty
    }

    func createDaily(
        task: DailyTask
    ) {
        guard newDailyValid(title: task.title) else { return }

        task.date = Calendar.current.startOfDay(for: task.date)
        do{
          try repository.create(task)
        } catch {
            alertMessage = error.localizedDescription
        }
    }

    func updateDaily(_ task: DailyTask){
        guard newDailyValid(title: task.title) else { return }

        task.date = Calendar.current.startOfDay(for: task.date)
        
        do{
            try repository.update(task)
        }catch{
            alertMessage = error.localizedDescription
        }
    }
    
    func deleteDaily(_ task: DailyTask) {
        do{
            try repository.delete(task)
        }catch{
            alertMessage = error.localizedDescription
        }
    }

    func toggleDailyCompletion(_ task: DailyTask) {
        task.isCompleted.toggle()
        task.completedAt = task.isCompleted ? Date() : nil
        print("Task \(task.isCompleted ? "tamamlandı" : "geri alındı").")
        
        do{
            try repository.update(task)
        }catch{
            alertMessage = error.localizedDescription
        }
            
    }

    func dailysForDate(_ tasks: [DailyTask], date: Date) -> [DailyTask] {
        return tasks.filter { Calendar.current.isDate($0.date, inSameDayAs: date) }
    }

    func todaysDailys(_ dailys: [DailyTask]) -> [DailyTask] {
        return dailys.filter { Calendar.current.isDate($0.date, inSameDayAs: Date()) }
    }

    func todaysActiveDailys(_ dailys: [DailyTask]) -> [DailyTask] {
        return dailys.filter { !$0.isCompleted && Calendar.current.isDate($0.date, inSameDayAs: Date()) }
    }

    func overdueDailys(_ dailys: [DailyTask]) -> [DailyTask] {
        return dailys.filter { !$0.isCompleted && $0.date < Date() && !Calendar.current.isDate($0.date, inSameDayAs: Date()) }
    }

    func todayCompletedDailys(_ dailys: [DailyTask]) -> [DailyTask] {
        return dailys.filter { $0.isCompleted && Calendar.current.isDate($0.completedAt ?? Date(), inSameDayAs: Date()) }
    }

    func priorityFilter(_ dailys: [DailyTask], priority: TaskPriority) -> [DailyTask] {
        return dailys.filter { $0.priority == priority }
    }

    func timeFilter(_ dailys: [DailyTask], filter: MatrixTimeFilter, date: Date = Date(), startDate: Date = Date(), endDate: Date = Date()) -> [DailyTask] {
        switch filter {
        case .daily:
            return dailys.filter { Calendar.current.isDate($0.date, inSameDayAs: date) }

        case .weekly:
            let timeInterval = Calendar.current.dateInterval(of: .weekOfYear, for: date)
            guard let times = timeInterval else { return [] }
            return dailys.filter { $0.date >= times.start && $0.date <= times.end }

        case .monthly:
            let timeInterval = Calendar.current.dateInterval(of: .month, for: date)
            guard let times = timeInterval else { return [] }
            return dailys.filter { $0.date >= times.start && $0.date <= times.end }

        case .custom:
            let timeInterval = startDate ... endDate
            return dailys.filter { timeInterval.contains($0.date) }
        }
    }

    func activeDailys(_ dailys: [DailyTask]) -> [DailyTask] {
        return dailys.filter { !$0.isCompleted }
    }
}
