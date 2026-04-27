//
//  RoutineDaySection.swift
//  DailyNest
//
//  Created by Atakan on 28.03.2026.
//

import SwiftUI

struct RoutineDaySection: View {
    @Bindable var routine: Routine

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(alignment: .center, spacing: 5) {
                ForEach(WeekDay.allCases) { day in
                    dayButton(day: day)
                }
                .padding(2)
            }
        }
    }

    private func dayButton(day: WeekDay) -> some View {
        let isSelected = routine.routineGoal.routineDays.contains(day)
        return Button(day.id.uppercased()) {
            if isSelected {
                routine.routineGoal.routineDays.removeAll { $0 == day }
            } else {
                routine.routineGoal.routineDays.append(day)
            }
        }
        .tint(isSelected ? AppColors.routine : AppColors.secondaryText)
        .frame(width: 50, height: 30)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.gray.opacity(0.05))
                .stroke(isSelected ? AppColors.routine : .gray.opacity(0.5), lineWidth: 1)
        )
    }
}
