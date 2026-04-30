//
//  ProgressCalculator.swift
//  DailyNest
//

import Foundation
import Observation
import SwiftUI

@Observable
final class ProgressCalculator {
    func config(
        dailyTasks: [DailyTask],
        routineTasks: [Routine],
        type: ProgressDataType
    ) -> ProgressCardConfig {
        let todayIndex = Calendar.current.component(.weekday, from: Date())
        let todayWeekDay = WeekDay(rawValue: todayIndex)

        let todaysTasks = dailyTasks.filter { Calendar.current.isDateInToday($0.date) }
        let activeRoutines = routineTasks.filter { routine in
            guard let today = todayWeekDay else { return false }
            return routine.routineGoal.routineDays.contains(today)
        }

        let completedCount: Int
        let totalCount: Int
        let title: String
        let colors: [Color]

        switch type {
        case .allTasks:
            totalCount = todaysTasks.count + activeRoutines.count
            completedCount = todaysTasks.filter { $0.isCompleted }.count + activeRoutines.filter { $0.isCompletedToday }.count
            title = "Today's Progress"
            colors = [AppColors.daily]

        case .dailyTasks:
            totalCount = todaysTasks.count
            completedCount = todaysTasks.filter { $0.isCompleted }.count
            title = "Today's Tasks"
            colors = [AppColors.daily, AppColors.daily.opacity(0.55)]

        case .routineTasks:
            totalCount = activeRoutines.count
            completedCount = activeRoutines.filter { $0.isCompletedToday }.count
            title = "Today's Routines"
            colors = [AppColors.routine, AppColors.routine.opacity(0.55)]
        }

        let progress = totalCount > 0 ? CGFloat(completedCount) / CGFloat(totalCount) : 0.0

        return ProgressCardConfig(
            title: title,
            progressPercentage: "%\(Int(round(progress * 100)))",
            progress: progress,
            progressText: "\(completedCount) / \(totalCount) completed.",
            progressColor: colors
        )
    }
}
