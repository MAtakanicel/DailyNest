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
    @Environment(\.modelContext) private var context

    @Query private var dailyTasks: [DailyTask]
    @Query(sort: \RoutineTask.createdAt, order: .reverse) private var routineTasks: [RoutineTask]

    // Section Açık mı Kapalı mı ?
    @AppStorage("pastSectionIsCollapsed") private var pastSectionIsCollapsed = false
    @AppStorage("todaySectionIsCollapsed") private var todaySectionIsCollapsed = false
    @AppStorage("routineSectionIsCollapsed") private var routineSectionIsCollapsed = false
    @AppStorage("completedSectionIsCollapsed") private var completedSectionIsCollapsed = false

    // Section görünür mü ?
    @AppStorage("pastSectionIsHidden") private var pastSectionIsHidden: Bool = false
    @AppStorage("completedSectionIsHidden") private var completedSectionIsHidden: Bool = false
    @AppStorage("todaySectionIsHidden") private var todaySectionIsHidden: Bool = false
    @AppStorage("routineSectionIsHidden") private var routineSectionIsHidden: Bool = false

    @State private var showNamePopUp: Bool
    @AppStorage("userName") private var userName: String = ""

    init() {
        let savedName = UserDefaults.standard.string(forKey: "userName") ?? ""
        _showNamePopUp = State(initialValue: savedName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
    }

    var body: some View {
        ZStack {
            AppColors.background.ignoresSafeArea()

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

                // Görevlerim Kısımı
                ScrollView {
                    LazyVStack(spacing: 0) {
                        DailysSections(
                            header: "Geçmiş Görevler",
                            items: dailyViewModel.overdueDailys(dailyTasks),
                            isExpanded: $pastSectionIsCollapsed,
                            context: context
                        )
                        .padding(.bottom, 20)
                        .visible(!dailyViewModel.overdueDailys(dailyTasks).isEmpty && !pastSectionIsHidden)

                        DailysSections(
                            header: "Today",
                            items: dailyViewModel.todaysDailys(dailyTasks),
                            isExpanded: $todaySectionIsCollapsed,
                            context: context
                        )
                        .padding(.bottom, 20)
                        .visible(!todaySectionIsHidden)

                        RoutineSection(
                            items: routineViewModel.todaysRoutines(routineTasks),
                            context: context,
                            isExpanded: $routineSectionIsCollapsed
                        )
                        .padding(.bottom, 20)
                        .visible(!routineSectionIsHidden)

                        DailysSections(
                            header: "Completed",
                            items: dailyViewModel.todayCompletedDailys(dailyTasks),
                            isExpanded: $completedSectionIsCollapsed,
                            context: context
                        )
                        .opacity(0.75)
                        .visible(!dailyViewModel.todayCompletedDailys(dailyTasks).isEmpty && !completedSectionIsHidden)
                    }
                }
                .padding(.horizontal, 20)
            }

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

    // MARK: - Üst Bar

    private var greetings: some View {
        VStack(alignment: .leading) {
            Text("\(homeViewModel.getDaytime())  \(userName) 👋")
                .font(.title2.bold())
                .foregroundColor(AppColors.primaryText)
                .padding(.bottom, 2)
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
                pastSectionIsHidden ? "Hide past task section" : "show Past Task Section",
                image: pastSectionIsHidden ? "eye.slash" : "eye"
            ) {
                pastSectionIsHidden.toggle()
            }

            menuVisibilityButton(
                completedSectionIsHidden ? "Hide completed section" : "Show Completed Section",
                image: completedSectionIsHidden ? "eye.slash" : "eye"
            ) {
                completedSectionIsHidden.toggle()
            }

            menuVisibilityButton(
                todaySectionIsHidden ? "Hide todays Section" : "Show Todays Section",
                image: todaySectionIsHidden ? "eye.slash" : "eye"
            ) {
                todaySectionIsHidden.toggle()
            }

            menuVisibilityButton(
                routineSectionIsHidden ? "Hide Routine Section" : "show Routine Section",
                image: routineSectionIsHidden ? "eye.slash" : "eye"
            ) {
                routineSectionIsHidden.toggle()
            }

        } label: {
            Image(systemName: "slider.horizontal.3")
                .resizable()
                .foregroundColor(AppColors.primaryText)
                .frame(width: 26, height: 22)
                .padding(10)
        }
    }

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

    private var trimmeduserName: String {
        userName.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

#Preview {
    TabBar(selectedTab: .main)
        .modelContainer(MockData.previewContainer)
        .environment(HomeViewModel())
        .environment(DailyViewModel())
        .environment(RoutineViewModel())
        .environment(SheetRouter())
}
