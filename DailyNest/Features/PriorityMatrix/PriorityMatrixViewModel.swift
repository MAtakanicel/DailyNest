//
//  PriorityMatrixViewModel.swift
//  DailyNest
//

import Foundation

@Observable @MainActor
final class PriorityMatrixViewModel {
    var timeFilterStartDate: Date = Date()
    var timeFilterEndDate: Date = Date()
    var isShowCompletedTasks: Bool = true
    var activeLocalSheet: PriorityMatrixSheet? = nil
    var alertMessage: String?

    private let service: DailyTaskService
    private let matrixSettings: MatrixSettings

    init(service: DailyTaskService, matrixSettings: MatrixSettings) {
        self.service = service
        self.matrixSettings = matrixSettings
    }

    var timeFilterState: MatrixTimeFilter {
        get { matrixSettings.timeFilterState }
        set { matrixSettings.timeFilterState = newValue }
    }

    func tasks(for priority: TaskPriority, from tasks: [DailyTask]) -> [DailyTask] {
        service.quadrant(
            from: tasks,
            priority: priority,
            showCompleted: isShowCompletedTasks,
            timeFilter: timeFilterState,
            date: Date(),
            startDate: timeFilterStartDate,
            endDate: timeFilterEndDate
        )
    }

    func applyTimeFilter(_ filter: MatrixTimeFilter) {
        timeFilterState = filter
    }

    func openSettingsSheet() {
        activeLocalSheet = .matrixSettingsSheet
    }

    func openCustomDateSheet() {
        activeLocalSheet = .customDateFilterSheet
    }
}
