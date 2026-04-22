//
//  AgendaView.swift
//  DailyNest
//
//  Created by Atakan on 30.01.2026.
//

import SwiftData
import SwiftUI

struct AgendaView: View {
    @Environment(CalendarHelper.self) private var calendarHelper
    @Environment(DailyViewModel.self) private var dailyViewModel
    @Environment(SheetRouter.self) private var sheetRouter

    @Query(sort: \DailyTask.date, order: .reverse) private var dailyTasks: [DailyTask]

    @State private var selectedDate = Date()
    @State private var displayedDate = Date()
    @State private var isExpanded = false
    @State private var isShowCompletedTasks: Bool = true

    private let rowHeight: CGFloat = 40

    private var isVisibleTaskList: Bool {
        !dailyViewModel.dailysForDate(dailyTasks, date: selectedDate).isEmpty
    }

    var body: some View {
        ZStack {
            AppColors.background.ignoresSafeArea()
            
            mainContent
            
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
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                navBarTitle
            }

            ToolbarItem(placement: .navigationBarTrailing) {
                tabBarMenu
            }
        }
    }
    
    private var mainContent: some View{
        VStack(spacing: 0) {
            // MARK: - Takvim Grid

            CalendarComponent(
                selectedDate: $selectedDate,
                displayedDate: $displayedDate,
                isExpanded: $isExpanded,
                rowHeight: rowHeight
            )
            Divider()

            if isVisibleTaskList {
                taskList
            } else {
                Spacer()
                emptyView
                Spacer()
            }
            Spacer()
        }
        .gesture(
            DragGesture()
                .onEnded { value in
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                        if value.translation.height > 30 {
                            isExpanded = true
                        } else if value.translation.height < -30 {
                            isExpanded = false
                        }
                    }
                }
        )
        .onChange(of: selectedDate) { _, newDate in
            displayedDate = newDate
        }

    }

    private var navBarTitle: some View {
        VStack(spacing: 2) {
            Text(calendarHelper.monthTitle(for: displayedDate))
                .font(.title2).bold()
            if !isExpanded {
                if selectedDate == Calendar.current.startOfDay(for: Date()) {
                    Text("Today")
                        .font(.caption)
                        .foregroundColor(AppColors.secondaryText)
                }
            }
        }
    }

    private var taskList: some View {
        ScrollView {
            LazyVStack {
                ForEach(
                    isShowCompletedTasks ? dailyViewModel.dailysForDate(dailyTasks, date: selectedDate) : dailyViewModel.activeDailys(dailyViewModel.dailysForDate(dailyTasks, date: selectedDate))
                ) { task in
                    DailyRow(task: task) { item in
                        sheetRouter.activeSheet = .taskDetail(item)
                    }
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
    }

    private var emptyView: some View {
        VStack(spacing: 20) {
            Image(systemName: "exclamationmark.triangle")
                .font(.largeTitle)
                .foregroundColor(.gray)
            Text("No tasks today.")
                .font(.title)
                .foregroundColor(.gray)
            Text("Tap + to add a new task.")
        }
    }

    private var tabBarMenu: some View {
        Menu {
            Button { isShowCompletedTasks.toggle() } label: {
                Text(
                    isShowCompletedTasks ?
                        "Hide completed tasks" :
                        "Show completed tasks"
                )
                Image(systemName: isShowCompletedTasks ? "eye.slash" : "eye")
            }

        } label: {
            Image(systemName: "slider.horizontal.3")
                .foregroundColor(AppColors.primaryText)
        }
    }
}

#Preview {
    TabBar(selectedTab: .agendaView)
        .modelContainer(MockData.previewContainer)
        .environment(ProgressCardViewModel())
        .environment(MockData.previewDailyViewModel)
        .environment(MockData.previewRoutineViewModel)
        .environment(SheetRouter())
        .environment(CalendarHelper())
}
