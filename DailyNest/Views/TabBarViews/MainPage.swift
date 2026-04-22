//
//  MainPage.swift
//  DailyNest
//
//  Created by Atakan on 30.01.2026.
//

import SwiftData
import SwiftUI

struct MainPage: View {
    @Environment(ProgressCardViewModel.self) private var progressCardViewModel
    @Environment(DailyViewModel.self) private var dailyViewModel
    @Environment(RoutineViewModel.self) private var routineViewModel
    @Environment(SheetRouter.self) private var sheetRouter
    @Environment(MainPageSettings.self) private var mainPageSettings
    @Environment(CalendarHelper.self) private var calendarHelper
    @Environment(AppSettings.self) private var appSettings

    @Query private var dailyTasks: [DailyTask]
    @Query(sort: \Routine.createdAt, order: .reverse) private var routineTasks: [Routine]

    var body: some View {
        @Bindable var settings = mainPageSettings
        ZStack {
            AppColors.background.ignoresSafeArea()

            mainContent

            // New Task Button
            VStack {
                Spacer()

                HStack {
                    Spacer()
                    NewTaskButton(mode: .daily, onTap: {
                        sheetRouter.activeSheet = .newDaily
                    })
                    .padding(.trailing, 20)
                    .padding(.bottom, 75)
                }
            }
        }
    }
    @ViewBuilder
    private var mainContent: some View{
        @Bindable var settings = mainPageSettings
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 0) {
                greetings

                Spacer()

                topMenu
            }
            .padding(.horizontal, 20)

            ProgressCard(config: progressCardViewModel.createProgressCard(dailyTasks: dailyTasks, routineTasks: routineTasks, type: .allTasks))
                .padding(.horizontal, 30)
                .padding(.vertical, 10)

            // Sections
            ScrollView {
                LazyVStack(spacing: 0) {
                    DailysSections(
                        header: "Overdue",
                        items: dailyViewModel.overdueDailys(dailyTasks),
                        isExpanded: $settings.pastSectionIsExpanded
                    )
                    .padding(.bottom, 20)
                    .visible(!dailyViewModel.overdueDailys(dailyTasks).isEmpty && !settings.pastSectionIsHidden)

                    DailysSections(
                        header: "Today",
                        items: dailyViewModel.todaysActiveDailys(dailyTasks),
                        isExpanded: $settings.todaySectionIsExpanded,
                    )
                    .padding(.bottom, 20)
                    .visible(!settings.todaySectionIsHidden)

                    RoutineSection(
                        items: routineViewModel.todaysRoutines(routineTasks),
                        isExpanded: $settings.routineSectionIsExpanded
                    )
                    .padding(.bottom, 20)
                    .visible(!settings.routineSectionIsHidden)

                    DailysSections(
                        header: "Completed",
                        items: dailyViewModel.todayCompletedDailys(dailyTasks),
                        isExpanded: $settings.completedSectionIsExpanded
                    )
                    .opacity(0.75)
                    .visible(!dailyViewModel.todayCompletedDailys(dailyTasks).isEmpty && !settings.completedSectionIsHidden)
                }
            }
            .padding(.horizontal, 20)
        }

    }
    
    
    // MARK: - Top Bar

    private var greetings: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("\(calendarHelper.getDaytime())  \(appSettings.userName) 👋")
                .font(.title2.bold())
                .foregroundColor(AppColors.primaryText)
                .padding(.top, 15)

            Text(calendarHelper.formattedDate())
                .font(.subheadline)
                .padding(.bottom, 1)
                .padding(.leading, 15)
        }
    }

    private var topMenu: some View {
        Menu {
            menuVisibilityButton(
                mainPageSettings.pastSectionIsHidden ? "Show Overdue Tasks" : "Hide Overdue Tasks",
                image: mainPageSettings.pastSectionIsHidden ? "eye" : "eye.slash"
            ) {
                withAnimation { mainPageSettings.pastSectionIsHidden.toggle() }
            }

            menuVisibilityButton(
                mainPageSettings.todaySectionIsHidden ? "Show Today's Tasks" : "Hide Today's Tasks",
                image: mainPageSettings.todaySectionIsHidden ? "eye" : "eye.slash"
            ) {
                withAnimation { mainPageSettings.todaySectionIsHidden.toggle() }
            }

            menuVisibilityButton(
                mainPageSettings.routineSectionIsHidden ? "Show Routines" : "Hide Routines",
                image: mainPageSettings.routineSectionIsHidden ? "eye" : "eye.slash"
            ) {
                withAnimation { mainPageSettings.routineSectionIsHidden.toggle() }
            }

            menuVisibilityButton(
                mainPageSettings.completedSectionIsHidden ? "Show Completed" : "Hide Completed",
                image: mainPageSettings.completedSectionIsHidden ? "eye" : "eye.slash"
            ) {
                withAnimation { mainPageSettings.completedSectionIsHidden.toggle() }
            }

        } label: {
            Image(systemName: "slider.horizontal.3")
                .resizable()
                .foregroundColor(AppColors.primaryText)
                .frame(width: 26, height: 22)
                .padding(10)
        }
    }

    /// Top Bar Buttons ( Visibility )
    private func menuVisibilityButton(_ title: String, image: String, tap: @escaping () -> Void) -> some View {
        Button { tap() } label: {
            Label("\(title)", systemImage: "\(image)")
                .foregroundColor(AppColors.primaryText)
        }
    }

}

#Preview {
    TabBar(selectedTab: .mainView)
        .modelContainer(MockData.previewContainer)
        .environment(ProgressCardViewModel())
        .environment(MockData.previewDailyViewModel)
        .environment(MockData.previewRoutineViewModel)
        .environment(SheetRouter())
        .environment(CalendarHelper())
        .environment(MainPageSettings())
        .environment(MatrixSettings())
        .environment(AppSettings())
}
