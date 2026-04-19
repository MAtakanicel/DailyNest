//
//  RoutineSheetView.swift
//  DailyNest
//
//  Created by Atakan on 11.03.2026.
//

import SwiftUI

struct RoutineSheetView: View {
    @State private var task: Routine
    @State private var mode: DetailSheetMode
    @State private var currentStep: Int = 0
    @State private var isAlertShown: Bool = false

    @Environment(RoutineViewModel.self) private var routineViewModel
    @Environment(SheetRouter.self) private var sheetRouter
    @Environment(CalendarHelper.self) private var calendarHelper
    @Environment(MatrixSettings.self) private var matrixSettings
    @Environment(\.dismiss) private var dismiss

    init(routine: Routine, mode: DetailSheetMode) {
        _mode = State(initialValue: mode)
        _task = State(initialValue: routine)
    }

    private var isLastStep: Bool { currentStep == 1 }
    private var step1Valid: Bool { routineViewModel.newRoutineValid(title: task.title) }

    var body: some View {
        NavigationStack {
            ZStack {
                AppColors.background.ignoresSafeArea()
                mainContent
            }
            .alert("Delete '\(task.title)'?", isPresented: $isAlertShown) {
                Button("Cancel", role: .cancel) { isAlertShown = false }
                Button("Confirm", role: .destructive) {
                    routineViewModel.deleteRoutine(task)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) { dismiss() }
                }
            } message: {
                Text("This action cannot be undone.")
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { toolbarContent }
        }
    }

    @ViewBuilder
    private var mainContent: some View {
        switch mode {
        case .detail:
            ScrollView {
                RoutineDetailSheet(task: task)
                    .padding(.horizontal, 25)
                    .padding(.top, 5)
            }

        case .create, .edit:
            VStack(spacing: 0) {
                stepIndicator
                    .padding(.top, 12)
                    .padding(.bottom, 6)

                TabView(selection: $currentStep) {
                    ScrollView {
                        RoutineStepBasicInfo(task: task)
                            .padding(.horizontal, 25)
                            .padding(.top, 5)
                    }
                    .tag(0)

                    ScrollView {
                        RoutineStepSchedule(task: task)
                            .padding(.horizontal, 25)
                            .padding(.top, 5)
                    }
                    .tag(1)


                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
            .animation(.smooth(duration: 0.4), value: currentStep)
        }
    }

    private var stepIndicator: some View {
        HStack(spacing: 6) {
            ForEach(0..<2) { i in
                Capsule()
                    .fill(i <= currentStep ? AppColors.routine : AppColors.secondaryText.opacity(0.25))
                    .frame(width: i == currentStep ? 28 : 8, height: 8)
                    .animation(.spring(response: 0.35, dampingFraction: 0.7), value: currentStep)
            }
        }
    }

    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .principal) {
            switch mode {
            case .create:
                VStack(spacing: 4) {
                    Text("New Routine")
                        .font(.headline.bold())
                        .foregroundColor(AppColors.primaryText)
                    Text("· Step \(currentStep + 1)/2")
                        .font(.caption)
                        .foregroundColor(AppColors.secondaryText)
                }
            case .edit:
                VStack(spacing: 0) {
                    Text(task.title)
                        .font(.title3.italic())
                        .foregroundColor(AppColors.primaryText)
                        .lineLimit(1)
                    Text("Editing · Step \(currentStep + 1)/3")
                        .font(.caption)
                        .foregroundColor(AppColors.secondaryText)
                }
            case .detail:
                NavBarTitle(mode: mode, isDaily: false, title: task.title)
            }
        }

        ToolbarItem(placement: .topBarLeading) {
            switch mode {
            case .create:
                if isLastStep{
                    Button("Back") { withAnimation { currentStep -= 1 }}
                        .foregroundColor(.red.opacity(0.9))
                        .font(.title3)
                }else {
                    Button("Cancel") { dismiss() }
                        .foregroundColor(.red.opacity(0.9))
                        .font(.title3)
                }
            case .detail:
                Button {
                    isAlertShown = true
                } label: {
                    Image(systemName: "trash")
                        .foregroundColor(.red.opacity(0.9))
                        .font(.title3.bold())
                }
            case .edit:
                Button { mode = .detail } label: {
                    Text("Back")
                        .font(.title3)
                        .foregroundColor(AppColors.primaryText)
                }
            }
        }

        ToolbarItem(placement: .topBarTrailing) {
            switch mode {
            case .detail:
                Button("Edit") {
                    currentStep = 0
                    mode = .edit
                }
                .font(.title3)
                .foregroundColor(AppColors.button)

            case .create:
                if isLastStep {
                    Button("Create") {
                        routineViewModel.createRoutine(task)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) { dismiss() }
                    }
                    .font(.title3)
                    .foregroundColor(step1Valid ? AppColors.routine : .gray.opacity(0.35))
                    .disabled(!step1Valid)
                } else {
                    Button("Next") {
                        withAnimation { currentStep += 1 }
                    }
                    .font(.title3)
                    .foregroundColor(currentStep == 0 ? (step1Valid ? AppColors.routine : .gray.opacity(0.35)) : AppColors.routine)
                    .disabled(currentStep == 0 && !step1Valid)
                }

            case .edit:
                if isLastStep {
                    Button("Done") {
                        routineViewModel.updateRoutine(task)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) { mode = .detail }
                    }
                    .font(.title3)
                    .foregroundColor(AppColors.button)
                } else {
                    Button("Next") {
                        withAnimation { currentStep += 1 }
                    }
                    .font(.title3)
                    .foregroundColor(AppColors.routine)
                }
            }
        }
    }
}

#Preview {
    RoutineSheetView(
        routine: Routine(
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
        ),
        mode: .create
    )
    .environment(MockData.previewRoutineViewModel)
    .environment(SheetRouter())
    .environment(CalendarHelper())
    .environment(MatrixSettings())
}
