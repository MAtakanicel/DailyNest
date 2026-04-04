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

    @Environment(DailyViewModel.self) private var dailyViewModel
    @Environment(SheetRouter.self) private var sheetRouter
    @Environment(CalendarHelper.self) private var calendarHelper
    @Environment(MatrixSettings.self) private var matrixSettings
    @Environment(\.dismiss) private var dismiss

    @State private var isAlertShown: Bool = false
    @State private var mode: DetailSheetMode

    init(dailyTask: DailyTask, mode: DetailSheetMode) {
        _mode = State(initialValue: mode)
        _task = State(initialValue: dailyTask)
    }

    var body: some View {
        NavigationStack {
            ZStack {
                AppColors.background.ignoresSafeArea()

                forms
                    .padding(.horizontal, 25)
                    .animation(.smooth(duration: 0.5), value: mode)
                    .padding(.top, 5)
            }
            .alert("Delete '\(task.title)'?", isPresented: $isAlertShown) {
                Button("Cancel", role: .cancel) {
                    isAlertShown.toggle()
                }

                Button("Confirm", role: .destructive) {
                    dailyViewModel.deleteDaily(task)

                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                        dismiss()
                    }
                }
            } message: {
                Text("This action cannot be undone.")
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    NavBarBackButton(mode: $mode, isAlertShown: $isAlertShown)
                }
                ToolbarItem(placement: .principal) {
                    NavBarTitle(mode: mode,isDaily: true, title: task.title)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    NavBarDoneButton(
                        mode: $mode,
                        isValid: dailyViewModel.newDailyValid(title: task.title),
                        isTask: true,
                        onConfirm: mode == .create ?
                            { dailyViewModel.createDaily(task: task) } :
                            { dailyViewModel.updateDaily(task) }
                    )
                }
            }
        }
    }

    private var forms: some View {
        ScrollView {
            switch mode {
            case .detail:
                DailyDetailView(task: task)
                    .padding(.horizontal, 10)

            case .create, .edit:
                VStack(alignment: .leading, spacing: 0) {
                    SectionDivider(deviderType: .top)

                    TitleField(title: $task.title)

                    SectionDivider(deviderType: .regular)

                    DescriptionField(details: $task.details)

                    SectionDivider(deviderType: .regular)

                    DateSection(date: $task.date)

                    SectionDivider(deviderType: .regular)

                    PrioritySection(selected: $task.priority)

                    SectionDivider(deviderType: .regular)

                    ReminderSection(isReminderOn: $task.isReminderOn, reminderDate: $task.reminderDate)
                    
                    SectionDivider(deviderType: .bottom)
                }
            }
        }
    }

}

#Preview {
    NavigationStack {
        DailySheetView(dailyTask: DailyTask(
            title: "Buy groceries",
            details: "Milk, eggs, bread",
            date: .now,
            priority: .veryHigh,
            isReminderOn: true
        ),
        mode: .create)
        .environment(MockData.previewDailyViewModel)
            .environment(SheetRouter())
            .environment(MatrixSettings())
            .environment(CalendarHelper())
    }
}
