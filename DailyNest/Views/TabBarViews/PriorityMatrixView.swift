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

struct PriorityMatrixView: View {
    @Environment(RoutineViewModel.self) private var routineViewModel
    @Environment(DailyViewModel.self) private var dailyViewModel

    @Query(sort: \DailyTask.date, order: .reverse) private var dailyTasks: [DailyTask]
    @Query private var routines: [RoutineTask]

    @AppStorage("matrixTimeFilter") private var timeFilterState: MatrixTimeFilter = .daily

    @AppStorage("quadrantTitle_VeryHigh") private var veryHighTitle: String = "Very High Priority"
    @AppStorage("quadrantTitle_High") private var highTitle: String = "High Priority"
    @AppStorage("quadrantTitle_Medium") private var mediumTitle: String = "Medium Priorty"
    @AppStorage("quadrantTitle_Low") private var lowTitle: String = "Low Priority"

    @AppStorage("quadrantIcon_VeryHigh") private var veryHighIcon: String = "🔴"
    @AppStorage("quadrantIcon_High") private var highIcon: String = "🟠"
    @AppStorage("quadrantIcon_Medium") private var mediumIcon: String = "🟡"
    @AppStorage("quadrantIcon_Low") private var lowIcon: String = "🟢"

    @State private var timeFilterStartDate: Date = .init()
    @State private var timeFilterEndDate: Date = .init()
    @State private var isShowCompletedTasks: Bool = true
    @State private var showCustomFilterSheet: Bool = false

    var body: some View {
        ZStack {
            AppColors.background.ignoresSafeArea()

            VStack(spacing: 10) {
                HStack(spacing: 10) {
                    quadrant(
                        priority: .veryHigh,
                        corner: .topLeading,
                        title: veryHighTitle,
                        icon: veryHighIcon
                    )

                    quadrant(
                        priority: .high,
                        corner: .topTrailing,
                        title: highTitle,
                        icon: highIcon
                    )
                }

                HStack(spacing: 10) {
                    quadrant(
                        priority: .medium,
                        corner: .bottomLeading,
                        title: mediumTitle,
                        icon: mediumIcon
                    )

                    quadrant(
                        priority: .low,
                        corner: .bottomTrailing,
                        title: lowTitle,
                        icon: lowIcon
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
                Menu {
                    Button { isShowCompletedTasks.toggle() } label: {
                        Text(
                            isShowCompletedTasks ?
                                "Hide completed tasks" :
                                "Show completed tasks"
                        )

                        Image(systemName: isShowCompletedTasks ? "eye.slash" : "eye")
                    }
                    Menu {
                        Button { timeFilterState = .daily } label: {
                            Text("Today Tasks")
                                .foregroundColor(AppColors.primaryText)
                        }

                        Button { timeFilterState = .weekly } label: {
                            Text("Weekly Tasks")
                                .foregroundColor(AppColors.primaryText)
                        }

                        Button { timeFilterState = .monthly } label: {
                            Text("Monthly Tasks")
                                .foregroundColor(AppColors.primaryText)
                        }

                        Button {
                            timeFilterState = .custom
                            showCustomFilterSheet.toggle()
                        } label: {
                            Text("Custom Filter")
                                .foregroundColor(AppColors.primaryText)
                        }
                    } label: {
                        Label("Time Filter", systemImage: "calendar")
                            .foregroundColor(AppColors.primaryText)
                    }

                } label: {
                    Image(systemName: "slider.horizontal.3")
                }
            }
        }
        .sheet(isPresented: $showCustomFilterSheet) {
            ZStack {
                AppColors.background.ignoresSafeArea()
                VStack {
                    Text("Time Filter")
                        .font(.title.bold())
                        .foregroundColor(AppColors.primaryText)
                    VStack(spacing: 25) {
                        DatePicker(
                            "Start Time",
                            selection: $timeFilterStartDate,
                            in: ...Date(),
                            displayedComponents: .date
                        )
                        .datePickerStyle(.compact)

                        DatePicker(
                            "End Time",
                            selection: $timeFilterEndDate,
                            in: timeFilterStartDate...,
                            displayedComponents: .date
                        )
                        .datePickerStyle(.compact)
                    }
                    .frame(maxWidth: 300)
                }
            }
            .presentationDetents([.fraction(0.3)])
        }
    }

    private func quadrant(priority: TaskPriority, corner: RoundedCorner, title: String, icon: String) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("\(icon) \(title)")
                .foregroundColor(AppColors.primaryText)
                .lineLimit(1)
                .padding(.top, 10)
                .padding(.leading, 10)

            Divider()
                .overlay(priority.color.opacity(0.1))
                .padding(.bottom, 5)

            ScrollView {
                LazyVStack(alignment: .leading, spacing: 0) {
                    ForEach(
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
                    ) { task in
                        Text(task.title)
                            .padding(.bottom, 5)
                    }
                }
                .padding(.horizontal, 10)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }

        .background {
            corner.backGroundShape()
                .fill(AppColors.overlayStroke.opacity(0.05))
                .overlay(
                    corner.backGroundShape()
                        .stroke(priority.color.opacity(0.25), lineWidth: 2.5)
                )
        }
    }
}

#Preview {
    TabBar(selectedTab: .priority)
        .modelContainer(MockData.previewContainer)
        .environment(HomeViewModel())
        .environment(DailyViewModel())
        .environment(RoutineViewModel())
}
