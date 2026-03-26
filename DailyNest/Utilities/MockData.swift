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
                title: "Sabah Yürüyüşü 🏃🏻‍♂️",
                details: "Günde en az 30 dakika tempolu yürüyüş.",
                routineDays: [.monday, .tuesday, .wednesday, .thursday, .friday], // Hafta içi
                isReminderOn: true,
                reminderTime: Calendar.current.date(bySettingHour: 7, minute: 0, second: 0, of: Date())
            ),
            Routine(
                title: "Kitap Oku 📚",
                details: "Yatmadan önce 20 sayfa.",
                routineDays: WeekDay.allCases,
                isReminderOn: false

            ),
            Routine(
                title: "Su İçmeyi Unutma 💧",
                maxCount: 5,
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
