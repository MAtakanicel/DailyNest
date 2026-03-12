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

    static var previewContainer: ModelContainer = {
        let schema = Schema([
            DailyTask.self,
            RoutineTask.self,
        ])

        let config = ModelConfiguration(isStoredInMemoryOnly: true) // Disk kaydı yapmasın.
        let container = try! ModelContainer(for: schema, configurations: [config])

        MockData.shared.insertSampleData(modelContext: container.mainContext)

        return container
    }()

    func insertSampleData(modelContext: ModelContext) {
        let routineTasks: [RoutineTask] = [
            RoutineTask(
                title: "Sabah Yürüyüşü 🏃🏻‍♂️",
                details: "Günde en az 30 dakika tempolu yürüyüş.",
                routineDays: [.monday, .tuesday, .wednesday, .thursday, .friday], // Hafta içi
                isReminderOn: true,
                reminderTime: Calendar.current.date(bySettingHour: 7, minute: 0, second: 0, of: Date())
            ),
            RoutineTask(
                title: "Kitap Oku 📚",
                details: "Yatmadan önce 20 sayfa.",
                routineDays: WeekDay.allCases,
                isReminderOn: false

            ),
            RoutineTask(
                title: "Su İçmeyi Unutma 💧",
                details: "Günde 2.5 Litre hedef.",
                routineDays: WeekDay.allCases
            ),
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
                reminderDate: Calendar.current.date(byAdding: .hour, value: 2, to: Date())
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
        ]

        for routineTask in routineTasks {
            modelContext.insert(routineTask)
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
