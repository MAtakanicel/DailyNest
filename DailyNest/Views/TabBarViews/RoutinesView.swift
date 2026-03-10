//
//  RoutinesView.swift
//  DailyNest
//
//  Created by Atakan on 10.03.2026.
//

import SwiftUI
import SwiftData

enum TaskFilter: String, CaseIterable, Hashable{
    case active = "Active Routines"
    case all = "All Routines"
    }


struct RoutinesView: View {
    @Query(sort: \RoutineTask.createdAt, order: .reverse) private var routineTasks : [RoutineTask]
    
    @ObservedObject var homeViewModel : HomeViewModel
    
    @State private var selectFilter : TaskFilter = .all
    @State private var searchText: String = ""
    
    init(homeViewModel: HomeViewModel){
        self.homeViewModel = homeViewModel
    }
    
    var body: some View {
        ZStack{
            
            AppColors.background.ignoresSafeArea()
            
            VStack(spacing: 16){
                ProgressCard(config: homeViewModel.createProgressCard(
                    dailyTasks: [],
                    routineTasks: routineTasks,
                    type: .routineTasks
                ))
                
                Picker("Filtre",selection: $selectFilter){
                    ForEach(TaskFilter.allCases, id: \.self){ filter in
                        Text(filter.rawValue)
                            .tag(filter)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.bottom,5)
                .padding(.horizontal,40)
                
                ScrollView{
                    LazyVStack{
                        Section{
                            ForEach(filtredRoutines){ task in
                                RoutineRow(routine: task, mode: .detailed)
                                }
                            }
                        }
                    }
                .padding()
                .background(GradientSectionBackground(viewStyle: .routinePage))
                .padding(.bottom,50)
                
            }
            .padding(.horizontal,20)
        }
        .navigationTitle("Routines")
        .navigationBarTitleDisplayMode(.inline)
        .searchable(text: $searchText,placement: .navigationBarDrawer(displayMode: . always),prompt: "Search Routine")
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
}

#Preview {
    RoutinesView(homeViewModel: HomeViewModel())
}
