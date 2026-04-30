//
//  MainPage.swift
//  DailyNest
//
//  Created by Atakan on 30.01.2026.
//

import SwiftData
import SwiftUI

struct MainPage: View {
    @Environment(MainPageViewModel.self) private var vm
    @Environment(SheetRouter.self) private var sheetRouter
    @Environment(MainPageSettings.self) private var mainPageSettings
    @Environment(CalendarHelper.self) private var calendarHelper
    @Environment(AppSettings.self) private var appSettings
    
    @Query private var dailyTasks: [DailyTask]
    @Query(sort: \Routine.createdAt, order: .reverse) private var routineTasks: [Routine]
    
    var body: some View {
        ZStack {
            AppColors.background.ignoresSafeArea()
            
            mainContent
            
            NewTaskButton(mode: .daily, onTap: { sheetRouter.activeSheet = .newDaily })
        }
        .navigationBarHidden(true)
        .alert("Error", isPresented: Binding(
            get: { vm.alertMessage != nil },
            set: { if !$0 { vm.alertMessage = nil } }
        )) {
            Button("OK") { vm.alertMessage = nil }
        } message: {
            Text(vm.alertMessage ?? "")
        }
    }
    
    @ViewBuilder
    private var mainContent: some View {
        @Bindable var settings = mainPageSettings
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 8) {
                greetings
                
                Spacer()
                
                priorityMatrixNavigationLink
                
                settingsMenu
            }
            .padding(.leading, 20)
            .padding(.trailing, 12)
            
            
            ProgressCard(config: vm.progressConfig(dailys: dailyTasks, routines: routineTasks, type: .allTasks))
                .padding(.horizontal, 30)
                .padding(.vertical, 10)
            
            ScrollView {
                LazyVStack(spacing: 0) {
                    DailysSections(
                        header: "Overdue",
                        items: vm.overdue(dailyTasks),
                        isExpanded: $settings.pastSectionIsExpanded,
                        onToggle: { vm.toggleDailyCompletion($0) }
                    )
                    .padding(.bottom, 20)
                    .visible(!vm.overdue(dailyTasks).isEmpty && !settings.pastSectionIsHidden)
                    
                    DailysSections(
                        header: "Today",
                        items: vm.todaysActive(dailyTasks),
                        isExpanded: $settings.todaySectionIsExpanded,
                        onToggle: { vm.toggleDailyCompletion($0) }
                    )
                    .padding(.bottom, 20)
                    .visible(!settings.todaySectionIsHidden)
                    
                    RoutineSection(
                        items: vm.todaysRoutines(routineTasks),
                        isExpanded: $settings.routineSectionIsExpanded,
                        onToggle: { vm.toggleRoutineCompletion($0) },
                        completionCount: { vm.todaysRoutineCount($0) }
                    )
                    .padding(.bottom, 20)
                    .visible(!settings.routineSectionIsHidden)
                    
                    DailysSections(
                        header: "Completed",
                        items: vm.todayCompleted(dailyTasks),
                        isExpanded: $settings.completedSectionIsExpanded,
                        onToggle: { vm.toggleDailyCompletion($0) }
                    )
                    .opacity(0.75)
                    .visible(!vm.todayCompleted(dailyTasks).isEmpty && !settings.completedSectionIsHidden)
                }
            }
            .padding(.horizontal, 20)
        }
    }
    
    // MARK: - Top Bar
    
    private var greetings: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("\(calendarHelper.getDaytime()) 👋")
                .font(.title2.bold())
                .foregroundColor(AppColors.primaryText)
                .padding(.top, 15)
            
            Text(calendarHelper.formattedDate())
                .font(.subheadline)
                .padding(.bottom, 1)
                .padding(.leading, 15)
        }
    }
    
    private var settingsMenu: some View {
        Menu {
            hideButton(
                mainPageSettings.pastSectionIsHidden ? "Show Overdue Tasks" : "Hide Overdue Tasks",
                image: mainPageSettings.pastSectionIsHidden ? "eye" : "eye.slash"
            ) { withAnimation { mainPageSettings.pastSectionIsHidden.toggle() } }
            
            hideButton(
                mainPageSettings.todaySectionIsHidden ? "Show Today's Tasks" : "Hide Today's Tasks",
                image: mainPageSettings.todaySectionIsHidden ? "eye" : "eye.slash"
            ) { withAnimation { mainPageSettings.todaySectionIsHidden.toggle() } }
            
            hideButton(
                mainPageSettings.routineSectionIsHidden ? "Show Routines" : "Hide Routines",
                image: mainPageSettings.routineSectionIsHidden ? "eye" : "eye.slash"
            ) { withAnimation { mainPageSettings.routineSectionIsHidden.toggle() } }
            
            hideButton(
                mainPageSettings.completedSectionIsHidden ? "Show Completed" : "Hide Completed",
                image: mainPageSettings.completedSectionIsHidden ? "eye" : "eye.slash"
            ) { withAnimation { mainPageSettings.completedSectionIsHidden.toggle() } }
        } label: {
            Image(systemName: "line.3.horizontal.decrease")
                .resizable()
                .foregroundColor(AppColors.primaryText)
                .fontWeight(.regular)
                .frame(width: 24, height: 14)
                .padding(16)
                .background(.white)
                .clipShape(Circle())
                .shadow(color: .black.opacity(0.12), radius: 4, x: 0, y: 2)
        }
    }
    
    private var priorityMatrixNavigationLink: some View {
        NavigationLink(destination: PriorityMatrixView()) {
            Image(systemName: "square.grid.2x2")
                .resizable()
                .foregroundColor(AppColors.primaryText)
                .fontWeight(.regular)
                .frame(width: 22, height: 22)
                .padding(12)
                .background(.white)
                .clipShape(Circle())
                .shadow(color: .black.opacity(0.12), radius: 4, x: 0, y: 2)
        }
    }
    
    private func hideButton(_ title: String, image: String, tap: @escaping () -> Void) -> some View {
        Button { tap() } label: {
            Label(title, systemImage: image)
                .foregroundColor(AppColors.primaryText)
        }
    }
    
    
}

#Preview {
    TabBar(selectedTab: .mainView)
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
