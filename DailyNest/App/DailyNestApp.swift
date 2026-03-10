//
//  DailyNestApp.swift
//  DailyNest
//
//  Created by Atakan on 28.01.2026.
//

import SwiftUI
import SwiftData

@main
struct DailyNestApp: App {
    let container: ModelContainer //DB Konteyneri
    
    init() {
        do{
            // Şema Tanımlaması, Veritabanındaki modeller
            let schema = Schema([
                DailyTask.self,
                RoutineTask.self
            ])
            
            // 2. Konfigürasyon: CloudKit
            // isStoredInMemoryOnly: False -> Veriler diskte saklansın. (Kalıcı)
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
            
            //3. Konteyner oluştur.
            container = try ModelContainer(for: schema,configurations: [modelConfiguration])
            
            print(modelConfiguration.url.path) //db yolunu ekrana fırlat
        }catch{
            fatalError("Veritabanı Hatası : \(error.localizedDescription)")
        }
    }
    
    var body: some Scene {
        WindowGroup{
            TabBar(homeViewModel: HomeViewModel())
        }.modelContainer(container) // Veri tabanı DI
    }
}
