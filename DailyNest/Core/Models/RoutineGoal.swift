//
//  RoutineGoal.swift
//  DailyNest
//
//  Created by Atakan on 26.04.2026.
//

import Foundation
import SwiftData

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

