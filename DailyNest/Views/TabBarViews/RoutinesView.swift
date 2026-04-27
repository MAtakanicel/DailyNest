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
    @Query(sort: \Routine.createdAt, order: .reverse) private var routineTasks: [Routine]

    @Environment(RoutineService.self) private var routineService
    @Environment(SheetRouter.self) private var sheetRouter
    @Environment(CalendarHelper.self) private var calendarHelper

    @State private var vm: RoutinesViewModel?

    var body: some View {
        ZStack {
            AppColors.background.ignoresSafeArea()

            if let vm {
                @Bindable var bindableVM = vm
                VStack(spacing: 16) {
                    weekRow(vm: vm)
                        .padding(.vertical, 10)
                        .background(GradientSectionBackground(viewStyle: .calendar))

                    searchBar(text: $bindableVM.searchText)

                    filterBar(selection: $bindableVM.selectFilter)

                    routineList(vm: vm)

                    Spacer()
                }
                .padding(.horizontal, 20)
            }

            NewTaskButton(mode: .routine, onTap: { sheetRouter.activeSheet = .newRoutine })
        }
        .navigationTitle("My Routines")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            if vm == nil { vm = RoutinesViewModel(service: routineService) }
        }
        .alert("Error", isPresented: Binding(
            get: { vm?.alertMessage != nil },
            set: { if !$0 { vm?.alertMessage = nil } }
        )) {
            Button("OK") { vm?.alertMessage = nil }
        } message: {
            Text(vm?.alertMessage ?? "")
        }
    }

    // MARK: - Components

    private func searchBar(text: Binding<String>) -> some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(AppColors.primaryText)
            TextField("Search Routine", text: text)
                .foregroundColor(AppColors.primaryText)
        }
        .padding(10)
        .background(.ultraThinMaterial)
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(.gray.opacity(0.7), lineWidth: 0.5))
        .cornerRadius(12)
        .padding(.horizontal, 20)
    }

    private func filterBar(selection: Binding<TaskFilter>) -> some View {
        Picker("Filter", selection: selection) {
            ForEach(TaskFilter.allCases, id: \.self) { Text($0.rawValue).tag($0) }
        }
        .pickerStyle(.segmented) 
        .padding(.bottom, 5)
        .padding(.horizontal, 40)
    }

    private func routineList(vm: RoutinesViewModel) -> some View {
        ScrollView {
            LazyVStack {
                ForEach(vm.displayedRoutines(routineTasks)) { task in
                    routineRow(routine: task, vm: vm)
                        .padding(.bottom, 5)
                }
            }
        }
    }

    private func routineRow(routine: Routine, vm: RoutinesViewModel) -> some View {
        HStack {
            Button { sheetRouter.activeSheet = .routineDetail(routine) } label: {
                Rectangle()
                    .fill(ColorHelper.color(from: routine.colorHex))
                    .frame(width: 10)
                    .padding(.trailing, 5)

                VStack(alignment: .leading, spacing: 0) {
                    Text(routine.title)
                        .foregroundColor(AppColors.cardText)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 12)

                    Text("\(vm.todaysCount(routine)) / \(routine.routineGoal.targetCount)")
                        .font(.subheadline)
                        .italic()
                        .foregroundStyle(AppColors.secondaryText)
                        .padding(.leading, 12)
                        .padding(.bottom, 10)
                }

                VStack(alignment: .trailing, spacing: 0) {
                    HStack(spacing: 0) {
                        Text("\(vm.streak(routine))")
                            .bold()
                            .foregroundColor(AppColors.primaryText)
                        Text(" days")
                            .foregroundColor(AppColors.secondaryText)
                            .font(.footnote)
                            .offset(y: 3)
                    }
                    .padding(.bottom, 8)
                    Text("Current Series")
                        .foregroundColor(AppColors.secondaryText.opacity(0.85))
                        .font(.caption)
                }
                .padding(.trailing, 10)
            }
        }
        .background(routine.isCompletedToday ?
            ComponentBackgrounds(component: .toDoCellCompleted) :
            ComponentBackgrounds(component: .toDoCellNotComplited))
        .cornerRadius(16)
        .shadow(color: .gray.opacity(0.25), radius: 2, x: 0, y: 2)
    }

    private func weekRow(vm: RoutinesViewModel) -> some View {
        HStack(spacing: 0) {
            ForEach(calendarHelper.weekDays(for: Date()), id: \.self) { date in
                DayCell(
                    date: date,
                    isSelected: calendarHelper.calendar.isDate(date, inSameDayAs: vm.selectedDate),
                    isToday: calendarHelper.calendar.isDateInToday(date),
                    isCurrentMonth: false,
                    hasDot: false,
                    mode: .routine
                )
                .padding(.horizontal, 5)
                .onTapGesture {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        vm.selectedDate = date
                    }
                }
            }
        }
    }
}

#Preview {
    TabBar(selectedTab: .routinesView)
        .modelContainer(MockData.previewContainer)
        .environment(MockData.previewDailyTaskService)
        .environment(MockData.previewRoutineService)
        .environment(ProgressCalculator())
        .environment(SheetRouter())
        .environment(CalendarHelper())
        .environment(MainPageSettings())
        .environment(MatrixSettings())
        .environment(AppSettings())
}
