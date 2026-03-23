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
    @Environment(\.modelContext) private var context
    
    @Query(sort: \DailyTask.date, order: .reverse) private var dailyTasks : [DailyTask]
    
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
                }else{
                    Spacer()
                    noTasksView
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
        .toolbar{
            ToolbarItem(placement: .principal) {
                navBarTitle
            }
            
            ToolbarItem(placement: .navigationBarTrailing){
                tabBarMenu
            }
        }
    }
    
    private var navBarTitle: some View {
        VStack(spacing: 2) {
            Text(calendarHelper.monthTitle(for: displayedDate))
                .font(.title2).bold()
            if !isExpanded {
                if selectedDate == Calendar.current.startOfDay(for: Date()) {
                    Text("Bugün")
                        .font(.caption)
                        .foregroundColor(AppColors.secondaryText)
                }
            }
        }
    }
    
    private var taskList: some View{
        ScrollView {
            LazyVStack {
                ForEach(
                    isShowCompletedTasks ? dailyViewModel.dailysForDate(dailyTasks, date: selectedDate) : dailyViewModel.activeDailys(dailyViewModel.dailysForDate(dailyTasks, date: selectedDate)),
                ){ task in
                    DailyRow(task: task, context: context){ item in
                        sheetRouter.activeSheet = .taskDetail(item)
                    }
                }
            }
        }
        .padding(.horizontal,20)
        .padding(.top,10)
        
    }
    
    private var noTasksView: some View {
        VStack(spacing: 20) {
            Image(systemName: "exclamationmark.triangle")
                .font(.largeTitle)
                .foregroundColor(.gray)
            Text("Bugün hiç görev yok.")
                .font(.title)
                .foregroundColor(.gray)
            Text("Yeni bir görev eklemek için +'yi tapabilirsin.")
        }
    }
    
    private var tabBarMenu: some View {
        Menu{
            Button { isShowCompletedTasks.toggle() } label: {
                Text(
                    isShowCompletedTasks ?
                        "Hide completed tasks" :
                        "Show completed tasks"
                )
                Image(systemName: isShowCompletedTasks ? "eye.slash" : "eye")
            }
            
        }label:{
            Image(systemName: "slider.horizontal.3")
                .foregroundColor(AppColors.primaryText)
        }
    }
    
}

#Preview {
    TabBar(selectedTab: .agendaView)
        .modelContainer(MockData.previewContainer)
        .environment(HomeViewModel())
        .environment(DailyViewModel())
        .environment(RoutineViewModel())
        .environment(SheetRouter())
        .environment(CalendarHelper())
}
