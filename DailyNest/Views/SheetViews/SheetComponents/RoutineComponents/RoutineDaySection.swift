//
//  RoutineDaySection.swift
//  DailyNest
//
//  Created by Atakan on 28.03.2026.
//

import SwiftUI

struct RoutineDaySection: View {
    let routine: Routine
    
    @Environment(RoutineViewModel.self) private var routineViewModel
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(alignment:.center ,spacing: 5){
                ForEach(WeekDay.allCases){ day in
                    dayButton(day: day)
                }
                .padding(2)
            }
        }
        
    }
    private func dayButton(day: WeekDay) -> some View {
        let isSelected = routine.routineGoal.routineDays.contains(day)
        
        return Button(day.id.uppercased()){ routineViewModel.toggleRoutineDay(routine, day: day, !isSelected) }
            .tint(isSelected ? AppColors.routine : AppColors.secondaryText)
            .frame(width: 50,height: 30)
        .background(
           RoundedRectangle(cornerRadius: 12)
                .fill(.gray.opacity(0.05))
                .stroke(isSelected ? AppColors.routine : .gray.opacity(0.5), lineWidth: 1)
                
        )
        
        
    }
}
/*
#Preview {
    NavigationStack {
        RoutineSheetView(routine: Routine(
            title: "Deneme",
            details: "Deniyoruz",
            tintColor: .blue,
            priority: .high,
            isReminderOn: false,
            reminderTime: .now,
            routineGoal: RoutineGoal(
                targetCount: 3, routineDays: [.friday,.sunday,.thursday], scheduleType: .daily, goalDate:, periodValue: <#T##Int#>, periodUnit: <#T##RoutinePeriodUnit#>
            )
        ),mode: .create
        )
        .environment(RoutineViewModel())
        .environment(SheetRouter())
        .environment(CalendarHelper())
        .environment(MatrixSettings())
    }
}
*/
