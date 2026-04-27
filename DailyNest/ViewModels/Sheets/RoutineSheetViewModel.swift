//
//  RoutineSheetViewModel.swift
//  DailyNest
//

import Foundation

@Observable @MainActor
final class RoutineSheetViewModel {
    var mode: DetailSheetMode
    var currentStep: Int = 0
    var isDeleteAlertShown: Bool = false
    var alertMessage: String?

    private let service: RoutineService

    init(mode: DetailSheetMode, service: RoutineService) {
        self.mode = mode
        self.service = service
    }

    var isLastStep: Bool { currentStep == 1 }

    func isValid(title: String) -> Bool {
        service.isValid(title: title)
    }

    func save(_ routine: Routine, onComplete: @escaping () -> Void) {
        do {
            switch mode {
            case .create: try service.create(routine)
            case .detail, .edit: try service.update(routine)
            }
            onComplete()
        } catch {
            alertMessage = error.localizedDescription
        }
    }

    func delete(_ routine: Routine, onComplete: @escaping () -> Void) {
        do {
            try service.delete(routine)
            onComplete()
        } catch {
            alertMessage = error.localizedDescription
        }
    }
}
