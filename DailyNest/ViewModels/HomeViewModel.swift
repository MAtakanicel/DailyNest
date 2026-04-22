//
//  ProgressCardViewModel.swift
//  DailyNest
//
//  Created by Atakan on 30.01.2026.
//

import Foundation
import Observation
import SwiftUI

@Observable @MainActor
final class ProgressCardViewModel {
    func createProgressCard(dailyTasks: [DailyTask], routineTasks: [Routine], type: ProgressDataType) -> ProgressCardConfig {
        let todayIndex = Calendar.current.component(.weekday, from: Date())
        let todayWeekDay = WeekDay(rawValue: todayIndex)

        let todaysTasks = dailyTasks.filter { Calendar.current.isDateInToday($0.date) }
        let activeRoutineTasks = routineTasks.filter { routine in
            guard let today = todayWeekDay else { return false }
            return routine.routineGoal.routineDays.contains(today)
        }

        var completedCount: Int
        var totalCount: Int
        var title: String
        var colors: [Color]

        switch type {
        case .allTasks:
            totalCount = todaysTasks.count + activeRoutineTasks.count
            completedCount = todaysTasks.filter { $0.isCompleted }.count + activeRoutineTasks.filter { $0.isCompletedToday }.count
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
}
