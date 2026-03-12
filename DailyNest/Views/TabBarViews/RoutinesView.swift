//
//  RoutinesView.swift
//  DailyNest
//
//  Created by Atakan on 10.03.2026.
//

import SwiftData
import SwiftUI

enum TaskFilter: String, CaseIterable, Hashable {
    case active = "Active Routines"
    case all = "All Routines"
}

struct RoutinesView: View {
    @Query(sort: \RoutineTask.createdAt, order: .reverse) private var routineTasks: [RoutineTask]

    @ObservedObject private var homeViewModel: HomeViewModel
    @ObservedObject private var routineViewModel: RoutineViewModel

    @State private var selectFilter: TaskFilter = .all
    @State private var searchText: String = ""

    init(homeViewModel: HomeViewModel, routineViewModel: RoutineViewModel) {
        self.homeViewModel = homeViewModel
        self.routineViewModel = routineViewModel
    }

    @State private var showNewRoutineSheet: Bool = false
    var body: some View {
        ZStack {
            AppColors.background.ignoresSafeArea()

            VStack(spacing: 16) {
                HStack(spacing: 0) {
                    Text("My Routines")
                        .font(.title2.bold())
                        .foregroundColor(AppColors.primaryText)
                        .padding(.bottom, 2)
                        .padding(.top, 15)

                    Spacer()

                    NewTaskButton(mode: .routine) { showNewRoutineSheet.toggle() }
                }

                ProgressCard(config: homeViewModel.createProgressCard(
                    dailyTasks: [],
                    routineTasks: routineTasks,
                    type: .routineTasks
                ))

                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(AppColors.primaryText)
                    TextField("Search Routine", text: $searchText)
                        .foregroundColor(AppColors.primaryText)
                }
                .padding(10)
                .background(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(.gray.opacity(0.7), lineWidth: 0.5)
                )
                .cornerRadius(12)
                .padding(.horizontal, 20)

                Picker("Filtre", selection: $selectFilter) {
                    ForEach(TaskFilter.allCases, id: \.self) { filter in
                        Text(filter.rawValue)
                            .tag(filter)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.bottom, 5)
                .padding(.horizontal, 40)

                ScrollView {
                    LazyVStack {
                        Section {
                            ForEach(filtredRoutines) { task in
                                RoutineRow(routine: task, mode: .detailed)
                            }
                        }
                    }
                }
                .padding()
                .background(GradientSectionBackground(viewStyle: .routinePage))
                .padding(.bottom, 50)

                Spacer()
            }
            .padding(.horizontal, 20)
        }
        .sheet(isPresented: $showNewRoutineSheet) {
            NewRoutineSheetView(routineViewModel: routineViewModel)
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
}

#Preview {
    RoutinesView(homeViewModel: HomeViewModel(), routineViewModel: RoutineViewModel())
        .modelContainer(MockData.previewContainer)
}
