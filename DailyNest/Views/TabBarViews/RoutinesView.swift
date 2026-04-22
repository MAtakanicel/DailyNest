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

    @Environment(RoutineViewModel.self) private var routineViewModel
    @Environment(HomeViewModel.self) private var homeViewModel
    @Environment(SheetRouter.self) private var sheetRouter
    @Environment(CalendarHelper.self) private var calendarHelper

    @State private var selectFilter: TaskFilter = .all
    @State private var searchText: String = ""
    @State private var selectedDate: Date = .init()

    var body: some View {
        ZStack {
            AppColors.background.ignoresSafeArea()

            VStack(spacing: 16) {
                weekRow()
                    .padding(.vertical, 10)
                    .background(GradientSectionBackground(viewStyle: .calendar))

                searchBar

                filterBar

                routineList
                
                Spacer()
            }
            .padding(.horizontal, 20)

            VStack {
                Spacer()
                HStack {
                    Spacer()
                    NewTaskButton(mode: .routine, onTap: { sheetRouter.activeSheet = .newRoutine })
                        .padding(.trailing, 20)
                        .padding(.bottom, 75) // tab bar yüksekliği kadar boşluk
                }
            }
        }
        .navigationTitle("My Routines")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: - Components
    
    /// Search Bar
    private var searchBar : some View{
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
    }
    
    /// Filter
    private var filterBar: some View {
        Picker("Filter", selection: $selectFilter) {
            ForEach(TaskFilter.allCases, id: \.self) { filter in
                Text(filter.rawValue)
                    .tag(filter)
            }
        }
        .pickerStyle(.segmented)
        .padding(.bottom, 5)
        .padding(.horizontal, 40)
    }
    
    /// Routine List
    private var routineList: some View{
        ScrollView {
            LazyVStack {
                Section {
                    ForEach(
                        routineViewModel.displayedRoutines(
                            forRoutinesView: routineTasks,
                            searchText: searchText,
                            selectedDate: selectedDate,
                            selectFilter: selectFilter)
                    ) { task in
                        routineRow(routine: task)
                            .padding(.bottom, 5)
                    }
                }
            }
        }
        
    }

    /// Routine Row
    private func routineRow(routine: Routine) -> some View {
        HStack {
            Button { sheetRouter.activeSheet = .routineDetail(routine) } label: {
                Circle()
                    .fill(routine.tintColor.color)
                    .frame(width: 18)
                    .padding(.leading, 8)
                VStack(alignment: .leading, spacing: 0) {
                    Text(routine.title)
                        .foregroundColor(AppColors.cardText)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 12)

                    Text("\(routineViewModel.todaysRoutineCompletionCount(routine)) / \(routine.routineGoal.targetCount)")
                        .font(.subheadline)
                        .italic()
                        .foregroundStyle(AppColors.secondaryText)
                        .padding(.leading, 12)
                        .padding(.bottom, 10)
                }

                VStack(alignment: .trailing, spacing: 0) {
                    HStack(spacing: 0) {
                        Text("\(routineViewModel.routineCompletionSeries(routine))")
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

    /// Week Row
    private func weekRow() -> some View {
        HStack(spacing: 0) {
            ForEach(calendarHelper.weekDays(for: Date()), id: \.self) { date in
                DayCell(
                    date: date,
                    isSelected: calendarHelper.calendar.isDate(date, inSameDayAs: selectedDate),
                    isToday: calendarHelper.calendar.isDateInToday(date),
                    isCurrentMonth: false,
                    hasDot: false,
                    mode: .routine
                )
                .padding(.horizontal, 5)
                .onTapGesture {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        selectedDate = date
                    }
                }
            }
        }
    }
}

#Preview {
    TabBar(selectedTab: .routinesView)
        .modelContainer(MockData.previewContainer)
        .environment(HomeViewModel())
        .environment(MockData.previewDailyViewModel)
        .environment(MockData.previewRoutineViewModel)
        .environment(SheetRouter())
        .environment(CalendarHelper())
}
