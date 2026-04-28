//
//  RoutineSheetView.swift
//  DailyNest
//
//  Created by Atakan on 11.03.2026.
//

import SwiftUI

struct RoutineSheetView: View {
    @State private var task: Routine
    @State private var vm: RoutineSheetViewModel
    @Environment(SheetRouter.self) private var sheetRouter
    @Environment(CalendarHelper.self) private var calendarHelper
    @Environment(MatrixSettings.self) private var matrixSettings
    @Environment(\.dismiss) private var dismiss

    init(routine: Routine, vm: RoutineSheetViewModel) {
        _task = State(initialValue: routine)
        _vm = State(initialValue: vm)
    }

    var body: some View {
        @Bindable var bindableVM = vm
        NavigationStack {
            ZStack {
                AppColors.background.ignoresSafeArea()
                mainContent
            }
            .alert("Delete '\(task.title)'?", isPresented: $bindableVM.isDeleteAlertShown) {
                Button("Cancel", role: .cancel) { vm.isDeleteAlertShown = false }
                Button("Confirm", role: .destructive) {
                    vm.delete(task) {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) { dismiss() }
                    }
                }
            } message: {
                Text("This action cannot be undone.")
            }
            .alert("Error", isPresented: Binding(
                get: { vm.alertMessage != nil },
                set: { if !$0 { vm.alertMessage = nil } }
            )) {
                Button("OK") { vm.alertMessage = nil }
            } message: {
                Text(vm.alertMessage ?? "")
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { toolbarContent }
        }
    }

    @ViewBuilder
    private var mainContent: some View {
        switch vm.mode {
        case .detail:
            ScrollView {
                RoutineDetailSheet(task: task)
                    .padding(.horizontal, 25)
                    .padding(.top, 5)
            }

        case .create, .edit:
            @Bindable var bindableVM = vm
            VStack(spacing: 0) {
                stepIndicator
                    .padding(.top, 12)
                    .padding(.bottom, 6)

                TabView(selection: $bindableVM.currentStep) {
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
            .animation(.smooth(duration: 0.4), value: vm.currentStep)
        }
    }

    private var stepIndicator: some View {
        HStack(spacing: 6) {
            ForEach(0..<2) { i in
                Capsule()
                    .fill(i <= vm.currentStep ? AppColors.routine : AppColors.secondaryText.opacity(0.25))
                    .frame(width: i == vm.currentStep ? 28 : 8, height: 8)
                    .animation(.spring(response: 0.35, dampingFraction: 0.7), value: vm.currentStep)
            }
        }
    }

    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .principal) {
            switch vm.mode {
            case .create:
                VStack(spacing: 4) {
                    Text("New Routine").font(.headline.bold()).foregroundColor(AppColors.primaryText)
                    Text("· Step \(vm.currentStep + 1)/2").font(.caption).foregroundColor(AppColors.secondaryText)
                }
            case .edit:
                VStack(spacing: 0) {
                    Text(task.title).font(.title3.italic()).foregroundColor(AppColors.primaryText).lineLimit(1)
                    Text("Editing · Step \(vm.currentStep + 1)/2").font(.caption).foregroundColor(AppColors.secondaryText)
                }
            case .detail:
                NavBarTitle(mode: vm.mode, isDaily: false, title: task.title)
            }
        }

        ToolbarItem(placement: .topBarLeading) {
            switch vm.mode {
            case .create:
                if vm.isLastStep {
                    Button("Back") { withAnimation { vm.currentStep -= 1 } }
                        .foregroundColor(.red.opacity(0.9)).font(.title3)
                } else {
                    Button("Cancel") { dismiss() }
                        .foregroundColor(.red.opacity(0.9)).font(.title3)
                }
            case .detail:
                Button { vm.isDeleteAlertShown = true } label: {
                    Image(systemName: "trash").foregroundColor(.red.opacity(0.9)).font(.title3.bold())
                }
            case .edit:
                Button { vm.mode = .detail } label: {
                    Text("Back").font(.title3).foregroundColor(AppColors.primaryText)
                }
            }
        }

        ToolbarItem(placement: .topBarTrailing) {
            switch vm.mode {
            case .detail:
                Button("Edit") { vm.currentStep = 0; vm.mode = .edit }
                    .font(.title3).foregroundColor(AppColors.daily)

            case .create:
                if vm.isLastStep {
                    Button("Create") {
                        vm.save(task) {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) { dismiss() }
                        }
                    }
                    .font(.title3)
                    .foregroundColor(vm.isValid(title: task.title) ? AppColors.routine : .gray.opacity(0.35))
                    .disabled(!vm.isValid(title: task.title))
                } else {
                    Button("Next") { withAnimation { vm.currentStep += 1 } }
                        .font(.title3)
                        .foregroundColor(vm.currentStep == 0
                            ? (vm.isValid(title: task.title) ? AppColors.routine : .gray.opacity(0.35))
                            : AppColors.routine)
                        .disabled(vm.currentStep == 0 && !vm.isValid(title: task.title))
                }

            case .edit:
                if vm.isLastStep {
                    Button("Done") {
                        vm.save(task) {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) { vm.mode = .detail }
                        }
                    }
                    .font(.title3).foregroundColor(AppColors.daily)
                } else {
                    Button("Next") { withAnimation { vm.currentStep += 1 } }
                        .font(.title3).foregroundColor(AppColors.routine)
                }
            }
        }
    }
}

#Preview {
    let service = MockData.previewRoutineService
    RoutineSheetView(
        routine: Routine(
            title: "Kitap Oku",
            details: "Yatmadan önce en az 20 sayfa kitap oku.",
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
        vm: RoutineSheetViewModel(mode: .create, service: service)
    )
    .environment(SheetRouter())
    .environment(CalendarHelper())
    .environment(MatrixSettings())
}
