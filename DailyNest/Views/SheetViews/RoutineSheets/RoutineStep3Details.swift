//
//  RoutineStep3Details.swift
//  DailyNest
//
//  Created by Atakan on 11.03.2026.
//

import SwiftUI

struct RoutineStep3Details: View {
    @Bindable var task: Routine
    @Environment(MatrixSettings.self) private var matrixSettings

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            SectionDivider(deviderType: .top)

            PrioritySection(selected: $task.priority)

            SectionDivider(deviderType: .regular)

            ReminderSection(isReminderOn: $task.isReminderOn, reminderDate: $task.reminderTime)

            SectionDivider(deviderType: .bottom)
        }
    }
}

#Preview {
    ScrollView {
        RoutineStep3Details(task: Routine(
            title: "Kitap Oku",
            details: "",
            tintColor: .green,
            priority: .high,
            isReminderOn: true,
            reminderTime: Calendar.current.date(bySettingHour: 22, minute: 0, second: 0, of: .now) ?? .now,
            routineGoal: RoutineGoal()
        ))
        .padding(.horizontal, 25)
    }
    .environment(MatrixSettings())
}
