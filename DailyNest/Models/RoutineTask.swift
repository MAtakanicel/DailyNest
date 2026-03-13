//
//  RoutineTask.swift
//  DailyNest
//
//  Created by Atakan on 30.01.2026.
//

import Foundation
import SwiftData

@Model
final class RoutineTask {
    var title: String
    var details: String? // Description

    var routineDays: [WeekDay]
    
    var maxCount: Int = 1
    
    @Relationship(deleteRule: .cascade)
    var completionHistory: [DailyLog]

    var isReminderOn: Bool
    var reminderTime: Date?

    var createdAt: Date

    var icon: String = "list.bullet"

    var tintColor: String = "blue"

    
    
    init(title: String,
         maxCount: Int = 1,
         details: String? = nil,
         routineDays: [WeekDay] = [.monday, .tuesday, .wednesday, .thursday, .friday], // Varsayılan: Hafta içi
         isReminderOn: Bool = false,
         reminderTime: Date? = nil)
    {
        self.title = title
        self.maxCount = maxCount
        self.details = details
        self.routineDays = routineDays
        self.isReminderOn = isReminderOn
        self.reminderTime = reminderTime

        
        createdAt = .now
        completionHistory = []
    }

    /// Bugün yapıldı mı kontrolü
    var isCompletedToday: Bool {
        let today = completionHistory.first(where: {Calendar.current.isDateInToday($0.date) })
        guard let completion = today else { return false }
        
        return completion.todaysCompletionCount == maxCount
    }
}

@Model
final class DailyLog{
    var date: Date
    var todaysCompletionCount : Int
    
    init(date: Date, todaysCompletionCount: Int = 0){
        self.date = date
        self.todaysCompletionCount = todaysCompletionCount
    }
}
