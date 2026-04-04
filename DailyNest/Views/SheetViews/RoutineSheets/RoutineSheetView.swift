//
//  RoutineSheetView.swift
//  DailyNest
//
//  Created by Atakan on 11.03.2026.
//

import SwiftUI

struct RoutineSheetView: View {
    @State private var task: Routine

    @Environment(RoutineViewModel.self) private var routineViewModel
    @Environment(SheetRouter.self) private var sheetRouter
    @Environment(CalendarHelper.self) private var calendarHelper
    @Environment(MatrixSettings.self) private var matrixSettings
    @Environment(\.dismiss) private var dismiss

    @State private var isAlertShown: Bool = false
    @State private var mode: DetailSheetMode

    init(routine: Routine, mode: DetailSheetMode) {
        _mode = State(initialValue: mode)
        _task = State(initialValue: routine)
    }
    var body: some View {
        NavigationStack{
            ZStack{
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
                    routineViewModel.deleteRoutine(task)

                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                        dismiss()
                    }
                }
            } message: {
                Text("This action cannot be undone.")
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .principal){
                NavBarTitle(mode: mode, isDaily: false, title: task.title)
            }
            ToolbarItem(placement: .topBarLeading){
                NavBarBackButton(mode: $mode, isAlertShown: $isAlertShown)
            }
            ToolbarItem(placement: .topBarTrailing){
                NavBarDoneButton(
                    mode: $mode,
                    isValid: routineViewModel.newRoutineValid(title: task.title),
                    isTask: false,
                    onConfirm: mode == .create ?
                        { routineViewModel.createRoutine(task) }:
                        { routineViewModel.updateRoutine(task) }
                            )
            }
        }
    }
    
    private  var forms : some View {
        ScrollView{
            switch mode {
            case .detail:
                RoutineDetailSheet(task: task)
            case .create, .edit:
                VStack(alignment: .leading, spacing: 0){
                    SectionDivider(deviderType: .top)
                    
                    TitleField(title: $task.title)
                    
                    SectionDivider(deviderType: .regular)
                    
                    DescriptionField(details: $task.details)
                    
                    SectionDivider(deviderType: .regular)
                    
                    RoutineDaySection(routine: task)
                    
                    SectionDivider(deviderType: .regular)
                    
                    VStack(spacing: 0){
                        Text("Daily Routine Count:")
                            .foregroundColor(AppColors.secondaryText)
                            .font(.subheadline)
                        
                        Stepper("", value: $task.routineGoal.targetCount,in: 1...10, step: 1)
                            
                    }
                }
            }
        }
    }
    
  
    
}

#Preview {
    NavigationStack {
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
        mode: .create)
       .environment(MockData.previewRoutineViewModel)
        .environment(SheetRouter())
        .environment(CalendarHelper())
        .environment(MatrixSettings())
    }
}


