//
//  RoutinesViewModel.swift
//  DailyNest
//

import Foundation

@Observable @MainActor
final class RoutinesViewModel {
    var selectFilter: TaskFilter = .all
    var searchText: String = ""
    var selectedDate: Date = Date()
    var alertMessage: String?

    private let service: RoutineService

    init(service: RoutineService) {
        self.service = service
    }

    func displayedRoutines(_ routines: [Routine]) -> [Routine] {
        service.displayed(routines, searchText: searchText, selectedDate: selectedDate, filter: selectFilter)
    }

    func todaysCount(_ routine: Routine) -> Int {
        service.todaysCount(routine)
    }

    func streak(_ routine: Routine) -> Int {
        service.completionSeries(routine)
    }

    func toggleCompletion(_ routine: Routine) {
        do { try service.toggleCompletion(routine) }
        catch { alertMessage = error.localizedDescription }
    }

    func resetCompletion(_ routine: Routine) {
        do { try service.resetCompletionToday(routine) }
        catch { alertMessage = error.localizedDescription }
    }
}
