//
//  HomeViewModel.swift
//  DailyNest
//
//  Created by Atakan on 30.01.2026.
//

import Foundation
import Combine
import SwiftUI

@MainActor
final class HomeViewModel : ObservableObject {
    
    
    func createProgressCard( dailyTasks:[DailyTask], routineTasks : [RoutineTask], type : ProgressDataType ) -> ProgressCardConfig{
        
        let todayIndex = Calendar.current.component(.weekday, from: Date()) //Bu gününün indexi
        let todayWeekDay = WeekDay(rawValue: todayIndex)
 
        
        let todaysTasks = dailyTasks.filter{ Calendar.current.isDateInToday($0.date)}
        let activeRoutineTasks = routineTasks.filter{ routine in
            guard let today = todayWeekDay else { return false }
            return routine.routineDays.contains(today)
        }
        
        var completedCount : Int
        var totalCount : Int
        var title : String
        var colors: [Color]
        
        switch type{
        case .allTasks:
            totalCount = todaysTasks.count + activeRoutineTasks.count
            completedCount = todaysTasks.filter{ $0.isCompleted }.count + activeRoutineTasks.filter{ $0.isCompletedToday }.count
            title = "Today's Progress"
            colors = [AppColors.progressBlue, AppColors.progressBlue.opacity(0.6)]
            
            case .dailyTasks:
                totalCount = todaysTasks.count
                completedCount = todaysTasks.filter { $0.isCompleted }.count
                title = "Today's Tasks"
                colors = [AppColors.progressPurple, AppColors.progressPurple.opacity(0.6)]
            
        case .routineTasks:
            totalCount = activeRoutineTasks.count
            completedCount = activeRoutineTasks.filter { $0.isCompletedToday }.count
            title = "Today's Routines"
            colors = [AppColors.progressGreen, AppColors.progressGreen.opacity(0.6)]
        }
        
        let progress = totalCount > 0 ? CGFloat(completedCount) / CGFloat(totalCount) : 0.0
        let percentString = "%\(Int(round(progress * 100)))"
        
        return ProgressCardConfig(
            title: title,
            progressPercentage: percentString,
            progress: progress,
            progressText: "\(completedCount) / \(totalCount) completed.",
            progressColor: colors
            )
    }
    
    func getDaytime() -> String {
        let calendar = Calendar(identifier: .gregorian)
        let hour = calendar.component(.hour, from: Date())
        
        if hour >= 0 && hour < 13 {
            return "Good Morning,"
        } else if hour >= 13 && hour < 19 {
            return "Hello,"
        } else {
            return "Good Evening,"
        }
    }
    
    func updateDate() -> String {
        return Date().formatted(.dateTime.weekday(.wide).day().month(.wide))
    }

    
}
