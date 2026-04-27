//
//  DailySheetView.swift
//  DailyNest
//
//  Created by Atakan on 11.03.2026.
//

import SwiftUI

enum DetailSheetMode {
    case create
    case detail
    case edit
}

struct DailySheetView: View {
    @State private var task: DailyTask
    @State private var vm: DailySheetViewModel
    @Environment(SheetRouter.self) private var sheetRouter
    @Environment(CalendarHelper.self) private var calendarHelper
    @Environment(MatrixSettings.self) private var matrixSettings
    @Environment(\.dismiss) private var dismiss

    init(dailyTask: DailyTask, vm: DailySheetViewModel) {
        _task = State(initialValue: dailyTask)
        _vm = State(initialValue: vm)
    }

    var body: some View {
        @Bindable var bindableVM = vm
        NavigationStack {
            ZStack {
                AppColors.background.ignoresSafeArea()

                forms
                    .padding(.horizontal, 25)
                    .animation(.smooth(duration: 0.5), value: vm.mode)
                    .padding(.top, 5)
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
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    NavBarBackButton(mode: $bindableVM.mode, isAlertShown: $bindableVM.isDeleteAlertShown)
                }
                ToolbarItem(placement: .principal) {
                    NavBarTitle(mode: vm.mode, isDaily: true, title: task.title)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    NavBarDoneButton(
                        mode: $bindableVM.mode,
                        isValid: vm.isValid(title: task.title),
                        isTask: true,
                        onConfirm: { vm.save(task) }
                    )
                }
            }
        }
    }

    private var forms: some View {
        ScrollView {
            switch vm.mode {
            case .detail:
                DailyDetailView(task: task, onToggle: { vm.toggleCompletion(task) })
                    .padding(.horizontal, 10)

            case .create, .edit:
                @Bindable var bindableTask = task
                VStack(alignment: .leading, spacing: 0) {
                    SectionDivider(deviderType: .top)
                    TitleField(title: $bindableTask.title)
                    SectionDivider(deviderType: .regular)
                    DescriptionField(details: $bindableTask.details, placeholder: "Description (optional)")
                    SectionDivider(deviderType: .regular)
                    DateSection(date: $bindableTask.date)
                    SectionDivider(deviderType: .regular)
                    PrioritySection(selected: $bindableTask.priority)
                    SectionDivider(deviderType: .regular)
                    ReminderSection(type: .task, isReminderOn: $bindableTask.isReminderOn, reminderDate: $bindableTask.reminderDate)
                    SectionDivider(deviderType: .bottom)
                }
            }
        }
    }
}

#Preview {
    let service = MockData.previewDailyTaskService
    NavigationStack {
        DailySheetView(
            dailyTask: DailyTask(title: "Buy groceries", details: "Milk, eggs, bread", date: .now, priority: .veryHigh, isReminderOn: true),
            vm: DailySheetViewModel(mode: .create, service: service)
        )
        .environment(SheetRouter())
        .environment(MatrixSettings())
        .environment(CalendarHelper())
    }
}
