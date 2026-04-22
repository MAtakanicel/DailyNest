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
    let container: ModelContainer // DB Konteyneri
    let dailyRepository : DailyTaskRepository
    let routineRepository : RoutineRepository

    init() {
        do {
            // Şema Tanımlaması, Veritabanındaki modeller
            let schema = Schema([
                DailyTask.self,
                Routine.self,
            ])

            // 2. Konfigürasyon: CloudKit
            // isStoredInMemoryOnly: False -> Veriler diskte saklansın. (Kalıcı)
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

            // 3. Konteyner oluştur.
            container = try ModelContainer(for: schema, configurations: [modelConfiguration])
            let dailyRepository = DailyTaskRepository(context: container.mainContext)
            self.dailyRepository = dailyRepository
            
            let routineRepository = RoutineRepository(context: container.mainContext)
            self.routineRepository = routineRepository
            
            _progressCardViewModel = State(initialValue: ProgressCardViewModel())
            _dailyViewModel = State(initialValue: DailyViewModel(repository: dailyRepository))
            _routineViewModel = State(initialValue: RoutineViewModel(repository: routineRepository))
            
            print(modelConfiguration.url.path) // db yolunu ekrana fırlat
        } catch {
            fatalError("Veritabanı Hatası : \(error.localizedDescription)")
        }
    }

    
    @State private var progressCardViewModel : ProgressCardViewModel
    @State private var dailyViewModel : DailyViewModel
    @State private var routineViewModel : RoutineViewModel
    @State private var sheetRouter = SheetRouter()
    @State private var calendarHelper = CalendarHelper()
    @State private var mainPageSettings = MainPageSettings()
    @State private var matrixSettings: MatrixSettings = .init()
    @State private var appSettings = AppSettings()

    var body: some Scene {
        WindowGroup {
            TabBar()
        }
        .modelContainer(container) // Veri tabanı DI
        .environment(progressCardViewModel)
        .environment(dailyViewModel)
        .environment(routineViewModel)
        .environment(sheetRouter)
        .environment(calendarHelper)
        .environment(mainPageSettings)
        .environment(matrixSettings)
        .environment(appSettings)
    }
}
