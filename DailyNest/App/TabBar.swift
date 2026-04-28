//
//  TabBar.swift
//  DailyNest
//
//  Created by Atakan on 30.01.2026.
//

import SwiftData
import SwiftUI

enum FloatingTab: String, CaseIterable {
    case mainView = "house.fill"
    case routinesView = "repeat"
    case agendaView = "calendar"
    case settingsView = "gear"
    case priorityMatrixView = "square.grid.2x2"
}

struct TabBar: View {
    @Environment(\.modelContext) private var context
    @Environment(SheetRouter.self) private var sheetRouter
    @Environment(AppSettings.self) private var appSettings
    @Environment(DailyTaskService.self) private var dailyService
    @Environment(RoutineService.self) private var routineService

    @Query private var dailyTasks: [DailyTask]
    @Query private var routineTasks: [Routine]

    @State var selectedTab: FloatingTab = .mainView
    @State private var showNamePopUp: Bool = false

    @Namespace private var tabBarAnimation

    var body: some View {
        @Bindable var router = sheetRouter
        @Bindable var bindableSettings = appSettings

        ZStack(alignment: .bottom) {
            mainContent
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .safeAreaInset(edge: .bottom) {
                    Color.clear.frame(height: 80)
                }
                .sheet(item: $router.activeSheet) { sheet in
                    switch sheet {
                    case .taskDetail(let task):
                        DailySheetView(
                            dailyTask: task,
                            vm: DailySheetViewModel(mode: .detail, service: dailyService)
                        )
                    case .routineDetail(let routine):
                        RoutineSheetView(
                            routine: routine,
                            vm: RoutineSheetViewModel(mode: .detail, service: routineService)
                        )
                    case .newDaily:
                        DailySheetView(
                            dailyTask: DailyTask(),
                            vm: DailySheetViewModel(mode: .create, service: dailyService)
                        )
                    case .newRoutine:
                        RoutineSheetView(
                            routine: Routine(routineGoal: RoutineGoal()),
                            vm: RoutineSheetViewModel(mode: .create, service: routineService)
                        )
                    }
                }

            tabBar

            if showNamePopUp {
                welcomePopUp(userName: $bindableSettings.userName)
                    .transition(.opacity.combined(with: .scale(scale: 0.95)))
            }
        }
        .ignoresSafeArea(.keyboard)
        .onAppear {
            checkAndLoadMockData()
            showNamePopUp = appSettings.userName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        }
    }

    private func checkAndLoadMockData() {
        #if DEBUG
        if dailyTasks.isEmpty, routineTasks.isEmpty {
            MockData.shared.insertSampleData(modelContext: context)
        }
        #endif
    }

    private var mainContent: some View {
        Group {
            switch selectedTab {
            case .mainView:         NavigationStack { MainPage() }
            case .routinesView:     NavigationStack { RoutinesView() }
            case .agendaView:       NavigationStack { AgendaView() }
            case .settingsView:     NavigationStack { SettingsView() }
            case .priorityMatrixView: NavigationStack { PriorityMatrixView() }
            }
        }
    }

    private var tabBar: some View {
        HStack(spacing: 0) {
            tabButton(.mainView)
            tabButton(.routinesView)
            tabButton(.agendaView)
            tabButton(.priorityMatrixView)
            tabButton(.settingsView)
        }
        .padding(.top, 10)
        .padding(.bottom, 10)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
        .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 6)
        .padding(.horizontal, 30)
    }

    // MARK: - Welcome Popup

    private func welcomePopUp(userName: Binding<String>) -> some View {
        let trimmed = userName.wrappedValue.trimmingCharacters(in: .whitespacesAndNewlines)

        return ZStack {
            Color.clear
                .background(.ultraThinMaterial)
                .ignoresSafeArea()

            VStack(spacing: 16) {
                VStack(spacing: 4) {
                    Text("Welcome to DailyNest")
                        .foregroundColor(AppColors.primaryText)
                        .font(.title2.bold())

                    Text("What should we call you?")
                        .foregroundStyle(AppColors.secondaryText)
                        .font(.subheadline)
                }

                TextField("Your name", text: userName)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(RoundedRectangle(cornerRadius: 16).fill(Color(.systemGray6)))
                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color(.systemGray4), lineWidth: 0.75))
                    .padding(.horizontal, 20)

                Button {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                        showNamePopUp = false
                    }
                } label: {
                    Text("Continue")
                        .foregroundStyle(trimmed.isEmpty ? .gray : AppColors.appleSignInText)
                        .font(.title3)
                        .padding(12)
                }
                .background(trimmed.isEmpty ? Color.gray.opacity(0.2) : AppColors.appleSignInBackground.opacity(0.85))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .disabled(trimmed.isEmpty)
            }
            .padding(.vertical)
            .background(RoundedRectangle(cornerRadius: 24).fill(Color(.systemBackground).opacity(0.75)))
            .overlay(RoundedRectangle(cornerRadius: 24).stroke(Color.gray.opacity(0.2), lineWidth: 1))
            .padding(25)
        }
    }

    private func tabButton(_ tab: FloatingTab) -> some View {
        Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                selectedTab = tab
            }
        } label: {
            VStack(spacing: 4) {
                Image(systemName: tab.rawValue)
                    .font(.system(size: 25, weight: .medium))

                if selectedTab == tab {
                    Circle()
                        .fill(AppColors.daily)
                        .frame(width: 5, height: 5)
                        .matchedGeometryEffect(id: "TabDot", in: tabBarAnimation)
                }
            }
            .foregroundColor(selectedTab == tab ? AppColors.daily : .gray.opacity(0.8))
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    TabBar()
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
