//
//  DailyDetailView.swift
//  DailyNest
//
//  Created by Atakan on 26.03.2026.
//

import SwiftUI

struct DailyDetailView: View {
    let task: DailyTask

    @Environment(CalendarHelper.self) private var calendarHelper
    @Environment(MatrixSettings.self) private var matrixSettings
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            SectionDivider(deviderType: .top)

            Text(task.details.isEmpty ? "No Description" : task.details)
                .foregroundColor(AppColors.primaryText)
                .font(.callout)
                .lineLimit(nil)
                .padding(4)
                .frame(maxWidth: .infinity, minHeight: 150, alignment: .topLeading)

            SectionDivider(deviderType: .regular)

            HStack(spacing: 0) {
                Text("Date: ")
                    .font(.headline.bold())
                    .foregroundColor(AppColors.primaryText)
                    .padding(.trailing, 5)

                Text("\(calendarHelper.formatDate(task.date, .full))")
                    .font(.body)
                    .foregroundColor(AppColors.secondaryText)
            }

            SectionDivider(deviderType: .regular)
            
            HStack(spacing: 0) {
                Text("Priority: ")
                    .font(.headline.bold())
                    .foregroundColor(AppColors.primaryText)
                    .padding(.trailing, 5)

                HStack(spacing: 6) {
                    Text("\(task.priority.icon(settings: matrixSettings))")
                        .font(.body)
                        .foregroundColor(AppColors.primaryText)

                    Text(task.priority.title(settings: matrixSettings))
                        .font(.body)
                        .foregroundColor(AppColors.primaryText)
                }
                .padding(10)
                .background(
                    Capsule()
                        .stroke(task.priority.color.opacity(0.85), lineWidth: 1.5)
                )
            }

            SectionDivider(deviderType: .regular)

            HStack(spacing: 0) {
                Text("Reminder:")
                    .foregroundColor(AppColors.primaryText)
                    .font(.headline.bold())
                    .padding(.trailing, 10)

                HStack(spacing: 8) {
                    Text(calendarHelper.formatDate(task.reminderDate, .full))
                        .font(.body)
                        .foregroundColor(AppColors.secondaryText)

                    Text(calendarHelper.formatDateTime(task.reminderDate, .short))
                        .font(.body)
                        .foregroundColor(AppColors.secondaryText)
                }
            }
            .visible(task.isReminderOn)
            .padding(.bottom, 10)

            SectionDivider(deviderType: .bottom)
        }
    }

}
