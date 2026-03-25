//
//  PriorityMatrixView.swift
//  DailyNest
//
//  Created by Atakan on 15.03.2026.
//

import SwiftData
import SwiftUI

enum RoundedCorner {
    case topLeading
    case topTrailing
    case bottomLeading
    case bottomTrailing

    func backGroundShape(radius: CGFloat = 20) -> UnevenRoundedRectangle {
        switch self {
        case .topLeading: return UnevenRoundedRectangle(topLeadingRadius: radius)
        case .topTrailing: return UnevenRoundedRectangle(topTrailingRadius: radius)
        case .bottomLeading: return UnevenRoundedRectangle(bottomLeadingRadius: radius)
        case .bottomTrailing: return UnevenRoundedRectangle(bottomTrailingRadius: radius)
        }
    }
}

enum MatrixTimeFilter: Int {
    case daily, weekly, monthly, custom
}

enum PriorityMatrixSheet: Identifiable {
    case customDateFilterSheet
    case matrixSettingsSheet
    
    var id :String{
        switch self {
        case .customDateFilterSheet: return "customDateFilter"
        case .matrixSettingsSheet: return "matrixSettingsSheet"
        }
    }
}

struct PriorityMatrixView: View {
    @Environment(RoutineViewModel.self) private var routineViewModel
    @Environment(DailyViewModel.self) private var dailyViewModel
    @Environment(\.modelContext) private var context
    @Environment(SheetRouter.self) private var sheetRouter
    @Environment(MatrixSettings.self) private var matrixSettings
   

    @Query(sort: \DailyTask.date, order: .reverse) private var dailyTasks: [DailyTask]
    @Query private var routines: [Routine]

    @State private var timeFilterStartDate: Date = .init()
    @State private var timeFilterEndDate: Date = .init()
    @State private var isShowCompletedTasks: Bool = true
    @State private var activeLocalSheet: PriorityMatrixSheet? = nil
    @AppStorage(MatrixSettingsKeys.quadrantTimefilterState) private var timeFilterState: MatrixTimeFilter = .daily
    
    var body: some View {
        ZStack {
            AppColors.background.ignoresSafeArea()

            VStack(spacing: 10) {
                HStack(spacing: 10) {
                    quadrant(
                        priority: .veryHigh,
                        corner: .topLeading
                    )

                    quadrant(
                        priority: .high,
                        corner: .topTrailing
                    )
                }

                HStack(spacing: 10) {
                    quadrant(
                        priority: .medium,
                        corner: .bottomLeading
                    )

                    quadrant(
                        priority: .low,
                        corner: .bottomTrailing
                    )
                }
            }
            .padding(.bottom, 70)
            .padding(.horizontal)
        }
        .navigationTitle("Priority Matrix")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                toolbarContent
            }
        }
        .sheet(item: $activeLocalSheet) { sheet in
            switch sheet {
            case .customDateFilterSheet:
                DatePickerSheet(
                    timeFilterStartDate: $timeFilterStartDate,
                    timeFilterEndDate: $timeFilterEndDate,
                    setDate: $timeFilterState
                )
                .presentationDetents([.fraction(0.35)])

            case .matrixSettingsSheet:
                MatrixSettingsSheet()
                    .presentationDetents([.large])

            }
        }
    }

    private func quadrant(priority: TaskPriority, corner: RoundedCorner) -> some View {
        var quadrantTasks: [DailyTask] {
            dailyViewModel.priorityFilter(
                dailyViewModel.timeFilter(
                    isShowCompletedTasks ? dailyTasks : dailyViewModel.activeDailys(dailyTasks),
                    filter: timeFilterState,
                    date: Date(),
                    startDate: timeFilterStartDate,
                    endDate: timeFilterEndDate
                ),
                priority: priority
            )
        }
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

            if !quadrantTasks.isEmpty {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 0) {
                        ForEach(quadrantTasks) { task in
                            DailyRow(task: task, context: context, rowStyle: .matrix) { _ in
                                sheetRouter.activeSheet = .taskDetail(task)
                            }
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
                            matrixSettings.quadrantMatrixColorIsShown ? priority.color.opacity(0.25) : AppColors.overlayStroke.opacity(0.1),
                            lineWidth: 1)
                )
        }
    }

    private func timeFilterButton(_ title: String, _ filter: MatrixTimeFilter) -> some View {
        Button { timeFilterState = filter } label: {
            Text(title)
                .foregroundColor(AppColors.primaryText)

            timeFilterState == filter ? Image(systemName: "checkmark") : nil
        }
    }
    
    private var toolbarContent : some View{
            Menu {
                Button { isShowCompletedTasks.toggle() } label: {
                    Text(
                        isShowCompletedTasks ?
                            "Hide completed tasks" :
                            "Show completed tasks"
                    )

                    Image(systemName: isShowCompletedTasks ? "eye.slash" : "eye")
                }

                Button{ matrixSettings.quadrantMatrixColorIsShown.toggle() } label: {
                    Label(
                        matrixSettings.quadrantMatrixColorIsShown ? "Priority Color disable" : "Priority Color enable",
                        systemImage: matrixSettings.quadrantMatrixColorIsShown ? "sun.min" : "sun.max")
                        .foregroundColor(AppColors.primaryText)
                }
                
                Button {
                    activeLocalSheet = .matrixSettingsSheet
                } label: {
                    Label("Priority Matrix Settings", systemImage: "gearshape")
                        .foregroundColor(AppColors.primaryText)
                }
                
                Menu {
                    timeFilterButton("Todays Tasks", .daily)

                    timeFilterButton("Weekly Tasks", .weekly)

                    timeFilterButton("Monthly Tasks", .monthly)

                    Button {
                        activeLocalSheet = .customDateFilterSheet
                    } label: {
                        Text("Custom Filter")
                            .foregroundColor(AppColors.primaryText)

                        timeFilterState == .custom ? Image(systemName: "checkmark") : nil
                    }
                }
                label: {
                    Label("Time Filter", systemImage: "calendar")
                        .foregroundColor(AppColors.primaryText)
                }

            } label: {
                Image(systemName: "slider.horizontal.3")
                    .foregroundColor(AppColors.primaryText)
            }
    }
}

#Preview {
    TabBar(selectedTab: .priorityMatrixView)
        .modelContainer(MockData.previewContainer)
        .environment(HomeViewModel())
        .environment(DailyViewModel())
        .environment(RoutineViewModel())
        .environment(SheetRouter())
        .environment(MatrixSettings())
}
