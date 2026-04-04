//
//  MockData.swift
//  DailyNest
//
//  Created by Atakan on 30.01.2026.
//

import Foundation
import SwiftData

@MainActor
class MockData {
    static let shared = MockData()

    static var previewDailyViewModel: DailyViewModel {
        DailyViewModel(repository: DailyTaskRepository(context: previewContainer.mainContext))
    }

    static var previewRoutineViewModel: RoutineViewModel {
        RoutineViewModel(repository: RoutineRepository(context: previewContainer.mainContext))
    }
    
    static var previewContainer: ModelContainer = {
        let schema = Schema([
            DailyTask.self,
            Routine.self,
        ])

        let config = ModelConfiguration(isStoredInMemoryOnly: true) // Disk kaydı yapmasın.
        let container = try! ModelContainer(for: schema, configurations: [config])

        MockData.shared.insertSampleData(modelContext: container.mainContext)

        return container
    }()

    func insertSampleData(modelContext: ModelContext) {
        let routineTasks: [Routine] = [
            Routine(
                title: "Su İç",
                details: "Uyanır uyanmaz ve gün içinde metabolizmayı hızlandırmak için su iç.",
                tintColor: .blue,
                priority: .high,
                isReminderOn: true,
                reminderTime: Calendar.current.date(bySettingHour: 9, minute: 0, second: 0, of: .now) ?? .now,
                routineGoal: RoutineGoal(
                    targetCount: 4,
                    routineDays: WeekDay.allCases
                )
            ),
            Routine(
                title: "Kitap Oku",
                details: "Yatmadan önce en az 20 sayfa kitap oku.",
                tintColor: .purple,
                priority: .medium,
                isReminderOn: true,
                reminderTime: Calendar.current.date(bySettingHour: 22, minute: 30, second: 0, of: .now) ?? .now,
                routineGoal: RoutineGoal(
                    targetCount: 1,
                    routineDays: [.monday, .tuesday, .wednesday, .thursday, .friday]
                )
            ),
            Routine(
                title: "SwiftUI Çalışması",
                details: "DailyNest projesine yeni özellikler ekle veya refactoring yap.",
                tintColor: .orange,
                priority: .high,
                isReminderOn: false,
                routineGoal: RoutineGoal(
                    targetCount: 1,
                    routineDays: [.monday, .wednesday, .friday]
                )
            ),
            Routine(
                title: "Fıtık Egzersizleri",
                details: "Sırt ve bel kaslarını güçlendirmek için mat egzersizleri yap.",
                tintColor: .green,
                priority: .medium,
                isReminderOn: true,
                reminderTime: Calendar.current.date(bySettingHour: 18, minute: 0, second: 0, of: .now) ?? .now,
                routineGoal: RoutineGoal(
                    targetCount: 1,
                    routineDays: [.tuesday, .thursday, .saturday]
                )
            ),
            Routine(
                title: "Meditasyon",
                details: "Haftanın stresini atmak için 15 dakika odaklanma ve nefes egzersizi.",
                tintColor: .yellow,
                priority: .low,
                isReminderOn: false,
                routineGoal: RoutineGoal(
                    targetCount: 1,
                    routineDays: [.saturday, .sunday]
                )
            )
        ]


        let dailyTasks: [DailyTask] = [
            DailyTask(
                title: "Market Alışverişi",
                details: "Süt, Yumurta, Ekmek ve Kahve alınacak.",
                date: Date(), // Bugün
                priority: .medium
            ),
            DailyTask(
                title: "Faturayı Öde",
                details: "İnternet faturası son gün!",
                date: Date(), // Bugün
                priority: .high,
                isReminderOn: true,
                reminderDate: Calendar.current.date(byAdding: .hour, value: 2, to: Date()) ?? Date(),
                isCompleted: true
            ),
            DailyTask(
                title: "SwiftUI Projesini Bitir",
                details: "Mock Data kısmını hallet ve UI tasarımına geç.",
                date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!, // Yarın
                priority: .high
            ),
            DailyTask(
                title: "Kediyi Veterinere Götür 🐈",
                date: Calendar.current.date(byAdding: .day, value: 2, to: Date())!, // 2 gün sonra
                priority: .low
            ),
            DailyTask(
                title: "Köpeği Veterinere Götür 🐈",
                date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!, // 2 gün önce
                priority: .low
            ),
        ]

        for Routine in routineTasks {
            modelContext.insert(Routine)
        }

        for dailyTask in dailyTasks {
            modelContext.insert(dailyTask)
        }

        do {
            try modelContext.save()
            print("Mock Data yüklemesi başarılı")
        } catch {
            print("Mock Data Yüklenemedi: \(error.localizedDescription)")
        }
    }
}
