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
    @Environment(\.modelContext) private var context
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
                    .padding(10)
            }
        }
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
                        { routineViewModel.createRoutine(task, context: context) }:
                        { routineViewModel.updateRoutine(task, context: context) }
                            )
            }
        }
    }
    
    private  var forms : some View {
        ScrollView{
            switch mode {
            case .detail:
            case .create, .edit:
            }
        }
    }
}

#Preview {
    NavigationStack {
        RoutineSheetView(routine: Routine(
            title: "Deneme",
            details: "Deniyoruz",
            icon: "list.bullet",
            routineDays: [.monday, .tuesday, .wednesday, .friday],
            maxCount: 3,
            tintColor: .blue,
            priority: .high,
            isReminderOn: false,
            reminderTime: .now
        ),mode: .create
        )
        .environment(RoutineViewModel())
        .environment(SheetRouter())
        .environment(CalendarHelper())
        .environment(MatrixSettings())
    }
}
