//
//  AgendaView.swift
//  DailyNest
//
//  Created by Atakan on 30.01.2026.
//

import SwiftData
import SwiftUI

struct AgendaView: View {
    @Environment(AgendaViewModel.self) private var vm
    @Environment(CalendarHelper.self) private var calendarHelper
    @Environment(SheetRouter.self) private var sheetRouter

    @Query(sort: \DailyTask.date, order: .reverse) private var dailyTasks: [DailyTask]

    private let rowHeight: CGFloat = 40

    var body: some View {
        ZStack {
            AppColors.background.ignoresSafeArea()

            mainContent
            NewTaskButton(mode: .daily, onTap: { sheetRouter.activeSheet = .newDaily })
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                navBarTitle
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                tabBarMenu
            }
        }
        .alert("Error", isPresented: Binding(
            get: { vm.alertMessage != nil },
            set: { if !$0 { vm.alertMessage = nil } }
        )) {
            Button("OK") { vm.alertMessage = nil }
        } message: {
            Text(vm.alertMessage ?? "")
        }
    }

    private var mainContent: some View {
        @Bindable var bindableVM = vm
        return VStack(spacing: 0) {
            CalendarComponent(
                selectedDate: $bindableVM.selectedDate,
                displayedDate: $bindableVM.displayedDate,
                isExpanded: $bindableVM.isExpanded,
                rowHeight: rowHeight
            )
            Divider()

            if vm.isTaskListVisible(dailyTasks) {
                taskList
            } else {
                Spacer()
                emptyView
                Spacer()
            }
            Spacer()
        }
        .gesture(
            DragGesture().onEnded { value in
                withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                    vm.handleDrag(translation: value.translation.height)
                }
            }
        )
        .onChange(of: vm.selectedDate) { _, newDate in
            vm.onDateChanged(newDate)
        }
    }

    private var navBarTitle: some View {
        VStack(spacing: 2) {
            Text(calendarHelper.monthTitle(for: vm.displayedDate))
                .font(.title2).bold()
            if !vm.isExpanded {
                if vm.selectedDate == Calendar.current.startOfDay(for: Date()) {
                    Text("Today")
                        .font(.caption)
                        .foregroundColor(AppColors.secondaryText)
                }
            }
        }
    }

    private var taskList: some View {
        ScrollView {
            LazyVStack {
                ForEach(vm.visibleTasks(dailyTasks)) { task in
                    DailyRow(
                        task: task,
                        onDetail: { sheetRouter.activeSheet = .taskDetail($0) },
                        onToggle: { vm.toggleCompletion($0) }
                    )
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
    }

    private var emptyView: some View {
        VStack(spacing: 20) {
            Image(systemName: "exclamationmark.triangle")
                .font(.largeTitle)
                .foregroundColor(.gray)
            Text("No tasks today.")
                .font(.title)
                .foregroundColor(.gray)
            Text("Tap + to add a new task.")
        }
    }

    private var tabBarMenu: some View {
        Menu {
            Button {
                vm.isShowCompletedTasks.toggle()
            } label: {
                Text(vm.isShowCompletedTasks ? "Hide completed tasks" : "Show completed tasks")
                Image(systemName: vm.isShowCompletedTasks ? "eye.slash" : "eye")
            }
        } label: {
            Image(systemName: "line.3.horizontal.decrease")
                .resizable()
                .foregroundColor(AppColors.primaryText)
                .fontWeight(.regular)
                .frame(width: 22, height: 12)
        }
    }
}

#Preview {
    TabBar(selectedTab: .agendaView)
        .modelContainer(MockData.previewContainer)
        .environment(SheetRouter())
        .environment(CalendarHelper())
        .environment(MockData.previewDailyTaskService)
        .environment(MockData.previewRoutineService)
        .environment(MockData.previewProgressCalculator)
        .environment(MockData.previewMainPageSettings)
        .environment(MockData.previewMatrixSettings)
        .environment(MockData.previewAppSettings)
        .environment(MockData.previewMainPageViewModel)
        .environment(MockData.previewAgendaViewModel)
        .environment(MockData.previewRoutinesViewModel)
        .environment(MockData.previewPriorityMatrixViewModel)
        .environment(MockData.previewSettingsViewModel)
}
