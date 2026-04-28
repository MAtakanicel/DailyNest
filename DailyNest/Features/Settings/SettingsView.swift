//
//  SettingsView.swift
//  DailyNest
//
//  Created by Atakan on 30.01.2026.
//

import SwiftData
import SwiftUI

struct SettingsView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    TabBar(selectedTab: .settingsView)
        .modelContainer(MockData.previewContainer)
        .environment(SheetRouter())
        .environment(CalendarHelper())
        .environment(MockData.previewDailyTaskService)
        .environment(MockData.previewRoutineService)
        .environment(MockData.previewProgressCalculator)
        .environment(MockData.previewMainPageSettings)
        .environment(MockData.previewMatrixSettings)
        .environment(MockData.previewAppSettings)
        .environment(MockData.previewMainPageViewModel)
        .environment(MockData.previewAgendaViewModel)
        .environment(MockData.previewRoutinesViewModel)
        .environment(MockData.previewPriorityMatrixViewModel)
        .environment(MockData.previewSettingsViewModel)
}
