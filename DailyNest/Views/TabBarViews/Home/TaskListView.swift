//
//  TaskLists.swift
//  DailyNest
//
//  Created by Atakan on 30.01.2026.
//

import SwiftUI
import SwiftData

enum Mode{
    case routinePage
    case dailyPage
}

enum TaskFilter: CaseIterable, Hashable{
    case active
    case all
    
    func title(for mode: Mode) -> String{
        switch (mode, self){
        case (.routinePage, .active):
        return "Active Routines"
            
        case (.routinePage, .all):
            return "All Routines"
            
        case (.dailyPage, .active):
            return "Active Tasks"
            
        case (.dailyPage, .all):
            return "All Tasks"
        }
    }
}

struct TaskListView: View {
    @ObservedObject var vm : HomeViewModel
    
    @Query(sort: \DailyTask.date, order: .reverse) private var dailyTasks : [DailyTask]
    @Query(sort: \RoutineTask.createdAt, order: .reverse) private var routineTasks : [RoutineTask]
    
    let mode: Mode
    
    @State private var selectFilter : TaskFilter = .all
    @State private var searchText: String = ""

    var progressConfig : ProgressCardConfig{
        switch mode{
        case .routinePage:
            return vm.createProgressCard(dailyTasks: dailyTasks, routineTasks: routineTasks, type: .routineTasks)
            
        case . dailyPage:
            return vm.createProgressCard(dailyTasks: dailyTasks, routineTasks: routineTasks, type: .dailyTasks)
        }
    }
    
    var filtredDailys : [DailyTask] {
        
        let searchFiltered = dailyTasks.filter { task in
            searchText.isEmpty ? true : task.title.localizedCaseInsensitiveContains(searchText)
        }
        
        switch selectFilter {
        case .active:
            return searchFiltered.filter{ !$0.isCompleted }
        case .all:
            return searchFiltered
        }
    }
    
    var filtredRoutines : [RoutineTask]{
        let searchFiltred = routineTasks.filter { task in
            searchText.isEmpty ? true : task.title.localizedCaseInsensitiveContains(searchText)
        }
        
        switch selectFilter {
        case .active:
            return searchFiltred.filter{ !$0.isCompletedToday }
        case .all:
            return searchFiltred
        }
    }
    
    var pageTitle: String{ mode == .dailyPage ? "My Tasks" : "My Routines" }
    
    var searchPrompt: String{ mode == .dailyPage ? "Search Tasks" : "Search Routines"}
    
    var body: some View {
            VStack(alignment:.leading,spacing: 0){
                
                
                ProgressCard(config: progressConfig)
                    .padding(.bottom,15)
                
                Picker("Filtre",selection: $selectFilter){
                    ForEach(TaskFilter.allCases, id: \.self){ filter in
                        Text(filter.title(for: mode))
                            .tag(filter)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.bottom,5)
                .padding(.horizontal,40)
                
                ScrollView{
                    LazyVStack{
                        Section{
                            switch mode {
                            case .routinePage:
                                ForEach(filtredRoutines){ task in
                                    RoutineRow(routine: task, mode: .detailed)
                                }
                            case .dailyPage:
                                ForEach(filtredDailys){ task in
                                    TaskRow(task: task, mode: .detailed)
                                }
                            }
                        }
                    }
                }
                
                .padding()
                .background(mode == .dailyPage ? GradientSectionBackground(viewStyle: .dailyPage) : GradientSectionBackground(viewStyle: .routinePage))
                .padding(.bottom,50)
                
                
            }
            .padding(20)
            .background(AppColors.background)
            .navigationTitle(pageTitle)
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText,placement: .navigationBarDrawer(displayMode: . always),prompt: searchPrompt)

        }
    }

#Preview {
    
}
