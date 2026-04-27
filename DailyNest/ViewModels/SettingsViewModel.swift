//
//  SettingsViewModel.swift
//  DailyNest
//

import Foundation

@Observable @MainActor
final class SettingsViewModel {
    private let appSettings: AppSettings

    init(appSettings: AppSettings) {
        self.appSettings = appSettings
    }
}
