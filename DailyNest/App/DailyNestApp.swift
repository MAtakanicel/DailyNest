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
    let dailyService: DailyTaskService
    let routineService: RoutineService
    let progressCalculator: ProgressCalculator

    @State private var sheetRouter = SheetRouter()
    @State private var calendarHelper = CalendarHelper()
    @State private var mainPageSettings = MainPageSettings()
    @State private var matrixSettings = MatrixSettings()
    @State private var appSettings = AppSettings()

    init() {
        do {
            let schema = Schema([
                DailyTask.self,
                Routine.self,
            ])
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
            container = try ModelContainer(for: schema, configurations: [modelConfiguration])

            let dailyRepo = DailyTaskRepository(context: container.mainContext)
            let routineRepo = RoutineRepository(context: container.mainContext)
            dailyService = DailyTaskService(repository: dailyRepo)
            routineService = RoutineService(repository: routineRepo)
            progressCalculator = ProgressCalculator()

            print(modelConfiguration.url.path)
        } catch {
            fatalError("Veritabanı Hatası : \(error.localizedDescription)")
        }
    }

    var body: some Scene {
        WindowGroup {
            TabBar()
        }
        .modelContainer(container)
        .environment(dailyService)
        .environment(routineService)
        .environment(progressCalculator)
        .environment(sheetRouter)
        .environment(calendarHelper)
        .environment(mainPageSettings)
        .environment(matrixSettings)
        .environment(appSettings)
    }
}
