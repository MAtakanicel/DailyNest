//
//  Routine.swift
//  DailyNest
//
//  Created by Atakan on 30.01.2026.
//

import Foundation
import SwiftData

@Model
final class Routine {
    var id: UUID = UUID()
    
    var title: String
    var details: String // Motivasyon
    
    @Relationship(deleteRule: .cascade)
    var routineGoal: RoutineGoal
    
    var tintColor: RoutineColor
    var priority: TaskPriority
    
    var isReminderOn: Bool
    var reminderTime: Date
    
    @Relationship(deleteRule: .cascade)
    var completionHistory: [DailyLog]
    var createdAt: Date
    
    @Relationship(deleteRule: .nullify)
    var category: [ObjectCategory]
    
    init(
        title: String = "",
        details: String = "",
        tintColor: RoutineColor = .blue,
        priority: TaskPriority = .medium,
        isReminderOn: Bool = false,
        reminderTime: Date = .now,
        routineGoal : RoutineGoal,
    ) {
        self.title = title
        self.details = details
        self.tintColor = tintColor
        self.priority = priority
        self.isReminderOn = isReminderOn
        self.reminderTime = reminderTime
        
        self.routineGoal = routineGoal
        
        createdAt = .now
        completionHistory = []
        category = []
    }

    /// Bugün yapıldı mı kontrolü
    var isCompletedToday: Bool {
        let today = completionHistory.first(where: { Calendar.current.isDateInToday($0.date) })
        guard let completion = today else { return false }

        return completion.todaysCompletionCount == routineGoal.targetCount
    }
}

@Model
final class DailyLog {
    var date: Date
    var todaysCompletionCount: Int

    init(date: Date, todaysCompletionCount: Int = 0) {
        self.date = date
        self.todaysCompletionCount = todaysCompletionCount
    }
}

@Model
final class RoutineGoal {
    var targetCount: Int // Periyot içinde tamamlama sayısı ( görevin bitmesi için)
    var routineDays: [WeekDay] //specific Days için hangi günler
    var scheduleType: RoutineScheduleType // tamamlama tipleri
    var goalDate: Date // hedeflenen zaman için
    var periodValue: Int // kaç periyot olacağı (günde 2 kez, haftada 4 kez...)
    var periodUnit: RoutinePeriodUnit // Adet birimi
    var startDate: Date
    
    init(
        targetCount: Int = 1,
        routineDays: [WeekDay] = [.monday, .tuesday, .wednesday, .thursday, .friday],
        scheduleType: RoutineScheduleType = .daily,
        goalDate: Date = Calendar.current.date(byAdding: .day, value: 1, to: .now) ?? .now,
        startDate: Date = .now,
        periodValue: Int = 1,
        periodUnit: RoutinePeriodUnit = .day
    ) {
        self.targetCount = targetCount
        self.routineDays = routineDays
        self.scheduleType = scheduleType
        self.goalDate = goalDate
        self.periodValue = periodValue
        self.periodUnit = periodUnit
        self.startDate = startDate
    }
}
