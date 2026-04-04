//
//  MainPage.swift
//  DailyNest
//
//  Created by Atakan on 30.01.2026.
//

import SwiftData
import SwiftUI

struct MainPage: View {
    @Environment(HomeViewModel.self) private var homeViewModel
    @Environment(DailyViewModel.self) private var dailyViewModel
    @Environment(RoutineViewModel.self) private var routineViewModel
    @Environment(SheetRouter.self) private var sheetRouter
    @Environment(AppSettings.self) private var appSettings

    @Query private var dailyTasks: [DailyTask]
    @Query(sort: \Routine.createdAt, order: .reverse) private var routineTasks: [Routine]

    @State private var showNamePopUp: Bool
    @AppStorage("userName") private var userName: String = ""

    private var trimmeduserName: String {
        userName.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    init() {
        let savedName = UserDefaults.standard.string(forKey: "userName") ?? ""
        _showNamePopUp = State(initialValue: savedName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
    }

    var body: some View {
        @Bindable var settings = appSettings
        ZStack {
            AppColors.background.ignoresSafeArea()

            // Top Bar
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 0) {
                    greetings

                    Spacer()

                    topMenu
                }
                .padding(.horizontal, 20)

                ProgressCard(config: homeViewModel.createProgressCard(dailyTasks: dailyTasks, routineTasks: routineTasks, type: .allTasks))
                    .padding(.horizontal, 30)
                    .padding(.vertical, 10)

                // Sections
                ScrollView {
                    LazyVStack(spacing: 0) {
                        DailysSections(
                            header: "Geçmiş Görevler",
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

            // New Task Button
            VStack {
                Spacer()

                HStack {
                    Spacer()
                    NewTaskButton(mode: .daily, onTap: {
                        sheetRouter.activeSheet = .newDaily
                    })
                    .padding(.trailing, 20)
                    .padding(.bottom, 75) // tab bar yüksekliği kadar boşluk
                }
            }

            if showNamePopUp {
                Color.clear
                    .background(.ultraThinMaterial)
                    .ignoresSafeArea()

                welcomePopUp
                    .padding(.vertical)
                    .background(
                        RoundedRectangle(cornerRadius: 24)
                            .fill(Color(.systemBackground).opacity(0.75))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                    )
                    .padding(25)
            }
        }
    }

    // MARK: - Top Bar

    private var greetings: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("\(homeViewModel.getDaytime())  \(userName) 👋")
                .font(.title2.bold())
                .foregroundColor(AppColors.primaryText)
                .padding(.top, 15)

            Text(homeViewModel.formattedDate())
                .font(.subheadline)
                .padding(.bottom, 1)
                .padding(.leading, 15)
        }
    }

    private var topMenu: some View {
        Menu {
            menuVisibilityButton(
                appSettings.pastSectionIsHidden ? "Show past task section" : "Hide Past Task Section",
                image: appSettings.pastSectionIsHidden ? "eye" : "eye.slash"
            ) {
                withAnimation { appSettings.pastSectionIsHidden.toggle() }
            }

            menuVisibilityButton(
                appSettings.todaySectionIsHidden ? "Show Todays Section" : "Hide todays Section",
                image: appSettings.todaySectionIsHidden ? "eye" : "eye.slash"
            ) {
                withAnimation { appSettings.todaySectionIsHidden.toggle() }
            }

            menuVisibilityButton(
                appSettings.routineSectionIsHidden ? "show Routine Section" : "Hide Routine Section",
                image: appSettings.routineSectionIsHidden ? "eye" : "eye.slash"
            ) {
                withAnimation { appSettings.routineSectionIsHidden.toggle() }
            }

            menuVisibilityButton(
                appSettings.completedSectionIsHidden ? "Show completed section" : "Hide Completed Section",
                image: appSettings.completedSectionIsHidden ? "eye" : "eye.slash"
            ) {
                withAnimation { appSettings.completedSectionIsHidden.toggle() }
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

    private var welcomePopUp: some View {
        VStack(spacing: 16) {
            VStack(spacing: 4) {
                Text("Welcome to DailyNest")
                    .foregroundColor(AppColors.primaryText)
                    .font(.title2)
                    .bold()

                Text("What should we call you?")
                    .foregroundStyle(AppColors.secondaryText)
                    .font(.subheadline)
            }

            TextField("Adınız", text: $userName)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.systemGray6))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color(.systemGray4), lineWidth: 0.75)
                )
                .padding(.horizontal, 20)

            Button(action: {
                showNamePopUp.toggle()
            }) {
                Text("Continue")
                    .foregroundStyle(trimmeduserName.isEmpty ? .gray : AppColors.appleSignInText)
                    .font(.title3)
                    .padding(12)
            }
            .background(trimmeduserName.isEmpty ? Color.gray.opacity(0.2) : AppColors.appleSignInBackground.opacity(0.85))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .disabled(trimmeduserName.isEmpty)
        }
    }
}

#Preview {
    TabBar(selectedTab: .mainView)
        .modelContainer(MockData.previewContainer)
        .environment(HomeViewModel())
        .environment(MockData.previewDailyViewModel)
        .environment(MockData.previewRoutineViewModel)
        .environment(SheetRouter())
        .environment(CalendarHelper())
        .environment(AppSettings())
        .environment(MatrixSettings())
}
