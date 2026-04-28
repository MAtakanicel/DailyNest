//
//  DailyNestApp.swift
//  DailyNest
//
//  Created by Atakan on 28.01.2026.
//

import SwiftData
import SwiftUI

@main
struct DailyNestApp: App {
    let container: ModelContainer

    // Services
    let dailyService: DailyTaskService
    let routineService: RoutineService
    let progressCalculator: ProgressCalculator

    // Settings
    let matrixSettings: MatrixSettings
    let mainPageSettings: MainPageSettings
    let appSettings: AppSettings

    // Page-level ViewModels
    let mainPageVM: MainPageViewModel
    let agendaVM: AgendaViewModel
    let routinesVM: RoutinesViewModel
    let priorityMatrixVM: PriorityMatrixViewModel
    let settingsVM: SettingsViewModel

    // App-level helpers
    @State private var sheetRouter = SheetRouter()
    @State private var calendarHelper = CalendarHelper()

    init() {
        do {
            let schema = Schema([DailyTask.self, Routine.self])
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
            container = try ModelContainer(for: schema, configurations: [modelConfiguration])

            // Repos
            let dailyRepo = DailyTaskRepository(context: container.mainContext)
            let routineRepo = RoutineRepository(context: container.mainContext)

            // Services
            let dailyService = DailyTaskService(repository: dailyRepo)
            let routineService = RoutineService(repository: routineRepo)
            let progressCalculator = ProgressCalculator()
            self.dailyService = dailyService
            self.routineService = routineService
            self.progressCalculator = progressCalculator

            // Settings
            let matrixSettings = MatrixSettings()
            let mainPageSettings = MainPageSettings()
            let appSettings = AppSettings()
            self.matrixSettings = matrixSettings
            self.mainPageSettings = mainPageSettings
            self.appSettings = appSettings

            // Page ViewModels
            self.mainPageVM = MainPageViewModel(
                dailyService: dailyService,
                routineService: routineService,
                calculator: progressCalculator
            )
            self.agendaVM = AgendaViewModel(service: dailyService)
            self.routinesVM = RoutinesViewModel(service: routineService)
            self.priorityMatrixVM = PriorityMatrixViewModel(
                service: dailyService,
                matrixSettings: matrixSettings
            )
            self.settingsVM = SettingsViewModel(appSettings: appSettings)
        } catch {
            fatalError("Veritabanı Hatası: \(error.localizedDescription)")
        }
    }

    var body: some Scene {
        WindowGroup {
            TabBar()
        }
        .modelContainer(container)
        // Services
        .environment(dailyService)
        .environment(routineService)
        .environment(progressCalculator)
        // Settings
        .environment(matrixSettings)
        .environment(mainPageSettings)
        .environment(appSettings)
        // Helpers
        .environment(sheetRouter)
        .environment(calendarHelper)
        // Page ViewModels
        .environment(mainPageVM)
        .environment(agendaVM)
        .environment(routinesVM)
        .environment(priorityMatrixVM)
        .environment(settingsVM)
    }
}
