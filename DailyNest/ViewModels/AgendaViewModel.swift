//
//  AgendaViewModel.swift
//  DailyNest
//

import Foundation

@Observable @MainActor
final class AgendaViewModel {
    var selectedDate: Date = Date()
    var displayedDate: Date = Date()
    var isExpanded: Bool = false
    var isShowCompletedTasks: Bool = true
    var alertMessage: String?

    private let service: DailyTaskService

    init(service: DailyTaskService) {
        self.service = service
    }

    func visibleTasks(_ tasks: [DailyTask]) -> [DailyTask] {
        let forDate = service.dailysForDate(tasks, date: selectedDate)
        return isShowCompletedTasks ? forDate : service.active(forDate)
    }

    func isTaskListVisible(_ tasks: [DailyTask]) -> Bool {
        !service.dailysForDate(tasks, date: selectedDate).isEmpty
    }

    func handleDrag(translation: CGFloat) {
        if translation > 30 { isExpanded = true }
        else if translation < -30 { isExpanded = false }
    }

    func onDateChanged(_ newDate: Date) {
        displayedDate = newDate
    }

    func toggleCompletion(_ task: DailyTask) {
        do { try service.toggleCompletion(task) }
        catch { alertMessage = error.localizedDescription }
    }
}
