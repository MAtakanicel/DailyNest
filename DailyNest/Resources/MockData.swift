//
//  MockData.swift
//  DailyNest
//
//  Created by Atakan on 30.01.2026.
//

import Foundation
import SwiftData
import Observation

@MainActor @Observable
class MockData {
    static let shared = MockData()

    static var previewDailyTaskService: DailyTaskService {
        DailyTaskService(repository: DailyTaskRepository(context: previewContainer.mainContext))
    }

    static var previewRoutineService: RoutineService {
        RoutineService(repository: RoutineRepository(context: previewContainer.mainContext))
    }

    static var previewContainer: ModelContainer = {
        let schema = Schema([
            DailyTask.self,
            Routine.self,
        ])
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: schema, configurations: [config])
        MockData.shared.insertSampleData(modelContext: container.mainContext)
        return container
    }()

    func insertSampleData(modelContext: ModelContext) {
        let routineTasks: [Routine] = [
            Routine(
                title: "Su İç",
                details: "Uyanır uyanmaz ve gün içinde metabolizmayı hızlandırmak için su iç.",
                priority: .high,
                isReminderOn: true,
                reminderTime: Calendar.current.date(bySettingHour: 9, minute: 0, second: 0, of: .now) ?? .now,
                routineGoal: RoutineGoal(targetCount: 4, routineDays: WeekDay.allCases)
            ),
            Routine(
                title: "Kitap Oku",
                details: "Yatmadan önce en az 20 sayfa kitap oku.",
                priority: .medium,
                isReminderOn: true,
                reminderTime: Calendar.current.date(bySettingHour: 22, minute: 30, second: 0, of: .now) ?? .now,
                routineGoal: RoutineGoal(targetCount: 1, routineDays: [.monday, .tuesday, .wednesday, .thursday, .friday])
            ),
            Routine(
                title: "SwiftUI Çalışması",
                details: "DailyNest projesine yeni özellikler ekle veya refactoring yap.",
                priority: .high,
                isReminderOn: false,
                routineGoal: RoutineGoal(targetCount: 1, routineDays: [.monday, .wednesday, .friday])
            ),
            Routine(
                title: "Fıtık Egzersizleri",
                details: "Sırt ve bel kaslarını güçlendirmek için mat egzersizleri yap.",
                priority: .medium,
                isReminderOn: true,
                reminderTime: Calendar.current.date(bySettingHour: 18, minute: 0, second: 0, of: .now) ?? .now,
                routineGoal: RoutineGoal(targetCount: 1, routineDays: [.tuesday, .thursday, .saturday])
            ),
            Routine(
                title: "Meditasyon",
                details: "Haftanın stresini atmak için 15 dakika odaklanma ve nefes egzersizi.",
                priority: .low,
                isReminderOn: false,
                routineGoal: RoutineGoal(targetCount: 1, routineDays: [.saturday, .sunday])
            )
        ]

        let dailyTasks: [DailyTask] = [
            DailyTask(title: "Market Alışverişi", details: "Süt, Yumurta, Ekmek ve Kahve alınacak.", date: Date(), priority: .medium),
            DailyTask(
                title: "Faturayı Öde",
                details: "İnternet faturası son gün!",
                date: Date(),
                priority: .high,
                isReminderOn: true,
                reminderDate: Calendar.current.date(byAdding: .hour, value: 2, to: Date()) ?? Date(),
                isCompleted: true
            ),
            DailyTask(title: "SwiftUI Projesini Bitir", details: "Mock Data kısmını hallet ve UI tasarımına geç.", date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!, priority: .high),
            DailyTask(title: "Kediyi Veterinere Götür 🐈", date: Calendar.current.date(byAdding: .day, value: 2, to: Date())!, priority: .low),
            DailyTask(title: "Köpeği Veterinere Götür 🐈", date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!, priority: .low),
        ]

        for routine in routineTasks { modelContext.insert(routine) }
        for dailyTask in dailyTasks { modelContext.insert(dailyTask) }

        try? modelContext.save()
    }
}
