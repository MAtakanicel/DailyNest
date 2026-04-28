//
//  MainPageViewModel.swift
//  DailyNest
//

import Foundation

@Observable @MainActor
final class MainPageViewModel {
    var alertMessage: String?

    private let dailyService: DailyTaskService
    private let routineService: RoutineService
    private let calculator: ProgressCalculator

    init(dailyService: DailyTaskService, routineService: RoutineService, calculator: ProgressCalculator) {
        self.dailyService = dailyService
        self.routineService = routineService
        self.calculator = calculator
    }

    // MARK: - Filters
    func overdue(_ tasks: [DailyTask]) -> [DailyTask] {
        dailyService.overdue(tasks)
    }

    func todaysActive(_ tasks: [DailyTask]) -> [DailyTask] {
        dailyService.todaysActive(tasks)
    }

    func todayCompleted(_ tasks: [DailyTask]) -> [DailyTask] {
        dailyService.todayCompleted(tasks)
    }

    func todaysRoutines(_ routines: [Routine]) -> [Routine] {
        routineService.todaysRoutines(routines)
    }

    func progressConfig(dailys: [DailyTask], routines: [Routine], type: ProgressDataType) -> ProgressCardConfig {
        calculator.config(dailyTasks: dailys, routineTasks: routines, type: type)
    }

    // MARK: - Actions
    func toggleDailyCompletion(_ task: DailyTask) {
        do { try dailyService.toggleCompletion(task) }
        catch { alertMessage = error.localizedDescription }
    }

    func toggleRoutineCompletion(_ routine: Routine) {
        do { try routineService.toggleCompletion(routine) }
        catch { alertMessage = error.localizedDescription }
    }

    func todaysRoutineCount(_ routine: Routine) -> Int {
        routineService.todaysCount(routine)
    }
}
