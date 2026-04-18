//
//  RoutineStep2Schedule.swift
//  DailyNest
//
//  Created by Atakan on 11.03.2026.
//

import SwiftUI

struct RoutineStep2Schedule: View {
    @Bindable var task: Routine

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            SectionDivider(deviderType: .top)

            scheduleTypePicker

            SectionDivider(deviderType: .regular)

            if task.routineGoal.scheduleType == .timed {
                frequencySection
                SectionDivider(deviderType: .regular)
            } else {
                activeDaysSection
                SectionDivider(deviderType: .regular)
            }

            dailyGoalSection

            SectionDivider(deviderType: .regular)

            goalDateSection

            SectionDivider(deviderType: .bottom)
        }
    }

    private var scheduleTypePicker: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Schedule Type")
                .font(.headline.bold())
                .foregroundColor(AppColors.primaryText)

            HStack(spacing: 8) {
                ForEach(RoutineScheduleType.allCases, id: \.self) { type in
                    scheduleTypeButton(type: type)
                }
            }
        }
    }

    private func scheduleTypeButton(type: RoutineScheduleType) -> some View {
        let isSelected = task.routineGoal.scheduleType == type
        return Button {
            withAnimation(.smooth(duration: 0.3)) {
                task.routineGoal.scheduleType = type
            }
        } label: {
            Text(type.rawValue.capitalized)
                .font(.subheadline.weight(.medium))
                .foregroundColor(isSelected ? .white : AppColors.primaryText)
                .padding(.horizontal, 18)
                .padding(.vertical, 9)
                .background(
                    Capsule()
                        .fill(isSelected ? AppColors.routine : .gray.opacity(0.1))
                        .stroke(
                            isSelected ? AppColors.routine : AppColors.overlayStroke.opacity(0.1),
                            lineWidth: 1
                        )
                )
        }
        .buttonStyle(.plain)
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: task.routineGoal.scheduleType)
    }

    private var activeDaysSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Active Days")
                .font(.headline.bold())
                .foregroundColor(AppColors.primaryText)

            RoutineDaySection(routine: task)
        }
        .transition(.opacity.combined(with: .move(edge: .top)))
    }

    private var frequencySection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Frequency")
                .font(.headline.bold())
                .foregroundColor(AppColors.primaryText)

            HStack(spacing: 16) {
                Stepper(value: $task.routineGoal.periodValue, in: 1...30) {
                    HStack(spacing: 4) {
                        Text("\(task.routineGoal.periodValue)")
                            .font(.title3.bold())
                            .foregroundColor(AppColors.routine)
                        Text("times")
                            .foregroundColor(AppColors.secondaryText)
                    }
                }

                Picker("", selection: $task.routineGoal.periodUnit) {
                    ForEach(RoutinePeriodUnit.allCases, id: \.self) { unit in
                        Text("per \(unit.rawValue)").tag(unit)
                    }
                }
                .pickerStyle(.menu)
                .tint(AppColors.routine)
                .padding(.horizontal, 8)
                .padding(.vertical, 6)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.gray.opacity(0.08))
                )
            }
        }
        .transition(.opacity.combined(with: .move(edge: .top)))
    }

    private var dailyGoalSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Daily Goal")
                .font(.headline.bold())
                .foregroundColor(AppColors.primaryText)

            Stepper(value: $task.routineGoal.targetCount, in: 1...10) {
                HStack(spacing: 6) {
                    Text("Complete")
                        .foregroundColor(AppColors.secondaryText)
                    Text("\(task.routineGoal.targetCount)x")
                        .font(.headline.bold())
                        .foregroundColor(AppColors.routine)
                    Text("per day")
                        .foregroundColor(AppColors.secondaryText)
                }
            }
            .padding(.trailing,12)
        }
    }

    private var goalDateSection: some View {
        HStack( spacing: 16) {
            Text("Goal End Date:")
                .font(.headline.bold())
                .foregroundColor(AppColors.primaryText)

            DatePicker(
                "",
                selection: $task.routineGoal.goalDate,
                in: Date.now...,
                displayedComponents: .date
            )
            .labelsHidden()
            .datePickerStyle(.compact)
            .tint(AppColors.routine)
        }
    }
    
    private var sessionUnit: String{
        switch task.routineGoal.periodUnit {
        case .day:
            return "day"
        
        case .week:
            return "week"
            
        case.month:
            return "month"
        }
    }
}

#Preview {
    ScrollView {
        RoutineStep2Schedule(task: Routine(
            title: "Kitap Oku",
            details: "",
            tintColor: .blue,
            priority: .medium,
            isReminderOn: false,
            reminderTime: .now,
            routineGoal: RoutineGoal(
                targetCount: 1,
                routineDays: [.monday, .wednesday, .friday],
                scheduleType: .daily,
                goalDate: .now,
                periodValue: 3,
                periodUnit: .week
            )
        ))
        .padding(.horizontal, 25)
    }
    .environment(MockData.previewRoutineViewModel)
}
