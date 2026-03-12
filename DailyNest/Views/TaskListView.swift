//
//  TaskListView.swift
//  DailyNest
//
//  Created by Atakan on 30.01.2026.
//

import SwiftData
import SwiftUI

enum Mode {
    case routinePage
    case dailyPage
}

struct TaskListView: View {
    @ObservedObject var vm: HomeViewModel

    @Query(sort: \DailyTask.date, order: .reverse) private var dailyTasks: [DailyTask]
    @Query(sort: \RoutineTask.createdAt, order: .reverse) private var routineTasks: [RoutineTask]

    let mode: Mode

    @State private var selectFilter: TaskFilter = .all
    @State private var searchText: String = ""

    var progressConfig: ProgressCardConfig {
        switch mode {
        case .routinePage:
            return vm.createProgressCard(dailyTasks: dailyTasks, routineTasks: routineTasks, type: .routineTasks)

        case .dailyPage:
            return vm.createProgressCard(dailyTasks: dailyTasks, routineTasks: routineTasks, type: .dailyTasks)
        }
    }

    var filteredDailys: [DailyTask] {
        let searchFiltered = dailyTasks.filter { task in
            searchText.isEmpty ? true : task.title.localizedCaseInsensitiveContains(searchText)
        }

        switch selectFilter {
        case .active:
            return searchFiltered.filter { !$0.isCompleted }
        case .all:
            return searchFiltered
        }
    }

    var filtredRoutines: [RoutineTask] {
        let searchFiltred = routineTasks.filter { task in
            searchText.isEmpty ? true : task.title.localizedCaseInsensitiveContains(searchText)
        }

        switch selectFilter {
        case .active:
            return searchFiltred.filter { !$0.isCompletedToday }
        case .all:
            return searchFiltred
        }
    }

    var pageTitle: String {
        mode == .dailyPage ? "My Tasks" : "My Routines"
    }

    var searchPrompt: String {
        mode == .dailyPage ? "Search Tasks" : "Search Routines"
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ProgressCard(config: progressConfig)
                .padding(.bottom, 15)
        }
        .padding(20)
        .background(AppColors.background)
        .navigationTitle(pageTitle)
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: searchPrompt)
    }
}

#Preview {}
