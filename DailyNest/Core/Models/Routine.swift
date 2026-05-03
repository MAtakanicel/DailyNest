//
//  Routine.swift
//  DailyNest
//
//  Created by Atakan on 30.01.2026.
//

import Foundation
import SwiftData

@Model
final class Routine :Taskable{
    var id: UUID = UUID()
    
    var title: String
    var details: String // Motivasyon
    
    @Relationship(deleteRule: .cascade)
    var routineGoal: RoutineGoal 
    
    var colorHex: String = AppColors.routineHex
    var priority: TaskPriority
    
    var isReminderOn: Bool
    var reminderTime: Date
    
    @Relationship(deleteRule: .cascade)
    var dailyLog: [RoutineDailyLog]
    var createdAt: Date
    
    @Relationship(deleteRule: .nullify)
    var category: [ObjectCategory]
    
    init(
        title: String = "",
        details: String = "",
        colorHex: String = AppColors.routineHex,
        priority: TaskPriority = .medium,
        isReminderOn: Bool = false,
        reminderTime: Date = .now,
        routineGoal : RoutineGoal,
    ) {
        self.title = title
        self.details = details
        self.colorHex = colorHex
        self.priority = priority
        self.isReminderOn = isReminderOn
        self.reminderTime = reminderTime
        self.routineGoal = routineGoal
        
        createdAt = .now
        dailyLog = []
        category = []
    }

    /// Bugün yapıldı mı kontrolü
    var isCompletedToday: Bool {
        let today = dailyLog.first(where: { Calendar.current.isDateInToday($0.date) })
        guard let completion = today else { return false }

        return completion.todaysCompletionCount == routineGoal.targetCount
    }
}



