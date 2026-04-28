//
//  PriorityMatrixView.swift
//  DailyNest
//
//  Created by Atakan on 15.03.2026.
//

import SwiftData
import SwiftUI

enum RoundedCorner {
    case topLeading, topTrailing, bottomLeading, bottomTrailing

    func backGroundShape(radius: CGFloat = 20) -> UnevenRoundedRectangle {
        switch self {
        case .topLeading:    return UnevenRoundedRectangle(topLeadingRadius: radius)
        case .topTrailing:   return UnevenRoundedRectangle(topTrailingRadius: radius)
        case .bottomLeading: return UnevenRoundedRectangle(bottomLeadingRadius: radius)
        case .bottomTrailing: return UnevenRoundedRectangle(bottomTrailingRadius: radius)
        }
    }
}

enum PriorityMatrixSheet: Identifiable {
    case customDateFilterSheet
    case matrixSettingsSheet

    var id: String {
        switch self {
        case .customDateFilterSheet: return "customDateFilter"
        case .matrixSettingsSheet:   return "matrixSettingsSheet"
        }
    }
}

struct PriorityMatrixView: View {
    @Environment(PriorityMatrixViewModel.self) private var vm
    @Environment(SheetRouter.self) private var sheetRouter
    @Environment(MatrixSettings.self) private var matrixSettings

    @Query(sort: \DailyTask.date, order: .reverse) private var dailyTasks: [DailyTask]

    var body: some View {
        @Bindable var bindableVM = vm
        ZStack {
            AppColors.background.ignoresSafeArea()

            matrixContent
                .padding(.bottom, 70)
                .padding(.horizontal)
                .sheet(item: $bindableVM.activeLocalSheet) { sheet in
                    switch sheet {
                    case .customDateFilterSheet:
                        DatePickerSheet(
                            timeFilterStartDate: $bindableVM.timeFilterStartDate,
                            timeFilterEndDate: $bindableVM.timeFilterEndDate,
                            setDate: Binding(
                                get: { vm.timeFilterState },
                                set: { vm.timeFilterState = $0 }
                            )
                        )
                        .presentationDetents([.fraction(0.35)])
                    case .matrixSettingsSheet:
                        MatrixSettingsSheet()
                            .presentationDetents([.large])
                    }
                }
        }
        .navigationTitle("Priority Matrix")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                toolbarContent
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

    private var matrixContent: some View {
        VStack(spacing: 10) {
            HStack(spacing: 10) {
                quadrant(priority: .veryHigh, corner: .topLeading)
                quadrant(priority: .high, corner: .topTrailing)
            }
            HStack(spacing: 10) {
                quadrant(priority: .medium, corner: .bottomLeading)
                quadrant(priority: .low, corner: .bottomTrailing)
            }
        }
    }

    private var toolbarContent: some View {
        Menu {
            Button {
                vm.isShowCompletedTasks.toggle()
            } label: {
                Text(vm.isShowCompletedTasks ? "Hide completed tasks" : "Show completed tasks")
                Image(systemName: vm.isShowCompletedTasks ? "eye.slash" : "eye")
            }

            Button { matrixSettings.quadrantMatrixColorIsShown.toggle() } label: {
                Label(
                    matrixSettings.quadrantMatrixColorIsShown ? "Priority Color disable" : "Priority Color enable",
                    systemImage: matrixSettings.quadrantMatrixColorIsShown ? "sun.min" : "sun.max"
                )
            }

            Button { vm.openSettingsSheet() } label: {
                Label("Priority Matrix Settings", systemImage: "gearshape")
            }

            Menu {
                timeFilterButton("Todays Tasks", .daily)
                timeFilterButton("Weekly Tasks", .weekly)
                timeFilterButton("Monthly Tasks", .monthly)
                Button {
                    vm.openCustomDateSheet()
                } label: {
                    Text("Custom Filter")
                    if vm.timeFilterState == .custom { Image(systemName: "checkmark") }
                }
            } label: {
                Label("Time Filter", systemImage: "calendar")
            }
        } label: {
            Image(systemName: "line.3.horizontal.decrease")
                .resizable()
                .foregroundColor(AppColors.primaryText)
                .fontWeight(.regular)
                .frame(width: 22, height: 12)
        }
    }

    private func quadrant(priority: TaskPriority, corner: RoundedCorner) -> some View {
        let tasks = vm.tasks(for: priority, from: dailyTasks)

        return VStack(alignment: .leading, spacing: 0) {
            Text("\(priority.icon(settings: matrixSettings)) \(priority.title(settings: matrixSettings))")
                .foregroundColor(AppColors.primaryText)
                .font(.footnote.bold())
                .lineLimit(1)
                .padding(.top, 10)
                .padding(.leading, 10)
                .padding(.bottom, 5)

            Divider()
                .overlay(priority.color.opacity(0.1))
                .padding(.bottom, 5)

            if !tasks.isEmpty {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 0) {
                        ForEach(tasks) { task in
                            DailyRow(
                                task: task,
                                rowStyle: .matrix,
                                onDetail: { sheetRouter.activeSheet = .taskDetail($0) }
                            )
                            .padding(.bottom, 5)
                        }
                    }
                    .padding(.horizontal, 10)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                VStack {
                    Text("Task not found")
                        .font(.subheadline)
                        .foregroundColor(AppColors.secondaryText.opacity(0.8))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .background {
            corner.backGroundShape()
                .fill(AppColors.overlayStroke.opacity(0.05))
                .overlay(
                    corner.backGroundShape()
                        .stroke(
                            matrixSettings.quadrantMatrixColorIsShown
                                ? priority.color.opacity(0.25)
                                : AppColors.overlayStroke.opacity(0.1),
                            lineWidth: 1
                        )
                )
        }
    }

    private func timeFilterButton(_ title: String, _ filter: MatrixTimeFilter) -> some View {
        Button { vm.applyTimeFilter(filter) } label: {
            Text(title)
            if vm.timeFilterState == filter { Image(systemName: "checkmark") }
        }
    }
}

#Preview {
    TabBar(selectedTab: .priorityMatrixView)
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
