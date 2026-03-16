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

    init() {
        do {
            // Şema Tanımlaması, Veritabanındaki modeller
            let schema = Schema([
                DailyTask.self,
                RoutineTask.self,
            ])

            // 2. Konfigürasyon: CloudKit
            // isStoredInMemoryOnly: False -> Veriler diskte saklansın. (Kalıcı)
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

            // 3. Konteyner oluştur.
            container = try ModelContainer(for: schema, configurations: [modelConfiguration])

            print(modelConfiguration.url.path) // db yolunu ekrana fırlat
        } catch {
            fatalError("Veritabanı Hatası : \(error.localizedDescription)")
        }
    }
    @State private var homeViewModel = HomeViewModel()
    @State private var dailyViewModel = DailyViewModel()
    @State private var routineViewModel = RoutineViewModel()
    var body: some Scene {
        WindowGroup {
            TabBar()
        }.modelContainer(container) // Veri tabanı DI
            .environment(homeViewModel)
            .environment(dailyViewModel)
            .environment(routineViewModel)
    }
}
