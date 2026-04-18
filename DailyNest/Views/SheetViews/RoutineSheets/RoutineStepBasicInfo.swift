//
//  RoutineStep1BasicInfo.swift
//  DailyNest
//
//  Created by Atakan on 11.03.2026.
//

import SwiftUI

struct RoutineStepBasicInfo: View {
    @Bindable var task: Routine

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            SectionDivider(deviderType: .top)

            TitleField(title: $task.title)

            SectionDivider(deviderType: .regular)

            DescriptionField(details: $task.details)

            SectionDivider(deviderType: .regular)

            colorPicker

            SectionDivider(deviderType: .bottom)
        }
    }

    private var colorPicker: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Color")
                .font(.headline.bold())
                .foregroundColor(AppColors.primaryText)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(RoutineColor.allCases, id: \.self) { color in
                        colorCircle(color: color)
                    }
                }
                .padding(.vertical, 4)
            }
        }
    }

    private func colorCircle(color: RoutineColor) -> some View {
        let isSelected = task.tintColor == color
        return Circle()
            .fill(color.color)
            .frame(width: 36, height: 36)
            .overlay(
                Circle()
                    .stroke(Color.white.opacity(0.8), lineWidth: isSelected ? 2.5 : 0)
            )
            .overlay(
                Image(systemName: "checkmark")
                    .font(.caption.bold())
                    .foregroundColor(.white)
                    .visible(isSelected)
            )
            .scaleEffect(isSelected ? 1.12 : 1.0)
            .animation(.spring(response: 0.25, dampingFraction: 0.6), value: task.tintColor)
            .onTapGesture { task.tintColor = color }
    }

}

#Preview {
    ScrollView {
        RoutineStepBasicInfo(task: Routine(
            title: "Kitap Oku",
            details: "Her gün okuma alışkanlığı",
            tintColor: .purple,
            priority: .medium,
            isReminderOn: false,
            reminderTime: .now,
            routineGoal: RoutineGoal()
        ))
        .padding(.horizontal, 25)
    }
    .environment(MatrixSettings())
}
