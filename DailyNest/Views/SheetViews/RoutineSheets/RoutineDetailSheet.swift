//
//  RoutineDetailSheet.swift
//  DailyNest
//
//  Created by Atakan on 27.03.2026.
//

import SwiftUI

struct RoutineDetailSheet: View {
    let task: Routine

    @Environment(CalendarHelper.self) private var calendarHelper
    @Environment(MatrixSettings.self) private var matrixSettings
    @Environment(RoutineViewModel.self) private var routineViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            SectionDivider(deviderType: .top)

            headerSection

            SectionDivider(deviderType: .regular)

            if !task.details.isEmpty {
                descriptionSection
                SectionDivider(deviderType: .regular)
            }

            scheduleSection

            SectionDivider(deviderType: .regular)

            prioritySection

            SectionDivider(deviderType: .regular)

            streakSection

            if task.isReminderOn {
                SectionDivider(deviderType: .regular)
                reminderSection
            }

            SectionDivider(deviderType: .regular)

            goalDateSection

            SectionDivider(deviderType: .bottom)
        }
    }

    private var headerSection: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text(task.title)
                    .font(.title3.bold())
                    .foregroundColor(AppColors.primaryText)
            }

            Spacer()

            Circle()
                .fill(task.tintColor.color)
                .frame(width: 14, height: 14)
        }
        .padding(.vertical, 4)
    }

    private var descriptionSection: some View {
        Text(task.details)
            .foregroundColor(AppColors.primaryText)
            .font(.callout)
            .lineLimit(nil)
            .padding(4)
            .frame(maxWidth: .infinity, minHeight: 60, alignment: .topLeading)
    }

    private var scheduleSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Schedule")
                .font(.headline.bold())
                .foregroundColor(AppColors.primaryText)

            HStack(spacing: 8) {
                Text(task.routineGoal.scheduleType.rawValue.capitalized)
                    .font(.subheadline.weight(.medium))
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 5)
                    .background(Capsule().fill(AppColors.routine))

                Text("· \(task.routineGoal.targetCount)× per day")
                    .font(.subheadline)
                    .foregroundColor(AppColors.secondaryText)
            }

            if task.routineGoal.scheduleType == .timed {
                Text("\(task.routineGoal.periodValue)× per \(task.routineGoal.periodUnit.rawValue)")
                    .font(.subheadline)
                    .foregroundColor(AppColors.secondaryText)
            } else if !task.routineGoal.routineDays.isEmpty {
                HStack(spacing: 4) {
                    ForEach(WeekDay.allCases) { day in
                        let isActive = task.routineGoal.routineDays.contains(day)
                        Text(day.id)
                            .font(.caption.bold())
                            .foregroundColor(isActive ? .white : AppColors.secondaryText)
                            .frame(width: 36, height: 26)
                            .background(
                                RoundedRectangle(cornerRadius: 7)
                                    .fill(isActive ? AppColors.routine : .gray.opacity(0.1))
                            )
                    }
                }
            }
        }
    }

    private var prioritySection: some View {
        HStack(spacing: 0) {
            Text("Priority: ")
                .font(.headline.bold())
                .foregroundColor(AppColors.primaryText)
                .padding(.trailing, 5)

            HStack(spacing: 6) {
                Text(task.priority.icon(settings: matrixSettings))
                    .font(.body)
                Text(task.priority.title(settings: matrixSettings))
                    .font(.body)
                    .foregroundColor(AppColors.primaryText)
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(
                Capsule()
                    .stroke(task.priority.color.opacity(0.85), lineWidth: 1.5)
            )
        }
    }

    private var streakSection: some View {
        HStack(spacing: 8) {
            Image(systemName: "flame.fill")
                .foregroundColor(.orange)
            Text("Streak:")
                .font(.headline.bold())
                .foregroundColor(AppColors.primaryText)
            Text("\(routineViewModel.routineCompletionSeries(task)) days")
                .font(.body)
                .foregroundColor(AppColors.secondaryText)
        }
    }

    private var reminderSection: some View {
        HStack(spacing: 0) {
            Text("Reminder: ")
                .font(.headline.bold())
                .foregroundColor(AppColors.primaryText)
                .padding(.trailing, 10)

            Text(calendarHelper.formatDateTime(task.reminderTime, .short))
                .font(.body)
                .foregroundColor(AppColors.secondaryText)
        }
    }

    private var goalDateSection: some View {
        HStack(spacing: 0) {
            Text("Goal Date: ")
                .font(.headline.bold())
                .foregroundColor(AppColors.primaryText)
                .padding(.trailing, 5)

            Text(calendarHelper.formatDate(task.routineGoal.goalDate, .medium))
                .font(.body)
                .foregroundColor(AppColors.secondaryText)
        }
    }
}

#Preview {
    NavigationStack {
        ScrollView {
            RoutineDetailSheet(task: Routine(
                title: "Kitap Oku",
                details: "Yatmadan önce en az 20 sayfa kitap oku.",
                tintColor: .purple,
                priority: .medium,
                isReminderOn: true,
                reminderTime: Calendar.current.date(bySettingHour: 22, minute: 30, second: 0, of: .now) ?? .now,
                routineGoal: RoutineGoal(
                    targetCount: 2,
                    routineDays: [.monday, .tuesday, .wednesday, .thursday, .friday],
                    scheduleType: .daily,
                    goalDate: .now,
                    periodValue: 1,
                    periodUnit: .day
                )
            ))
            .padding(.horizontal, 25)
        }
        .environment(MockData.previewRoutineViewModel)
        .environment(SheetRouter())
        .environment(CalendarHelper())
        .environment(MatrixSettings())
    }
}
