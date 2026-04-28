//
//  DailySheetViewModel.swift
//  DailyNest
//

import Foundation

@Observable @MainActor
final class DailySheetViewModel {
    var mode: DetailSheetMode
    var isDeleteAlertShown: Bool = false
    var alertMessage: String?

    private let service: DailyTaskService

    init(mode: DetailSheetMode, service: DailyTaskService) {
        self.mode = mode
        self.service = service
    }

    func isValid(title: String) -> Bool {
        service.isValid(title: title)
    }

    func save(_ task: DailyTask) {
        do {
            switch mode {
            case .create: try service.create(task)
            case .detail, .edit: try service.update(task)
            }
        } catch {
            alertMessage = error.localizedDescription
        }
    }

    func toggleCompletion(_ task: DailyTask) {
        do { try service.toggleCompletion(task) }
        catch { alertMessage = error.localizedDescription }
    }

    func delete(_ task: DailyTask, onComplete: @escaping () -> Void) {
        do {
            try service.delete(task)
            onComplete()
        } catch {
            alertMessage = error.localizedDescription
        }
    }
}
