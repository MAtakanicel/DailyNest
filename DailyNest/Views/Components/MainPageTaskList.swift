//
//  MainPageTaskList.swift
//  DailyNest
//
//  Created by Atakan on 30.01.2026.
//
import SwiftUI
import SwiftData

struct MainPageTaskList: View {
    
    @Query(sort: \DailyTask.date, order: . reverse ) private var dailyTasks : [DailyTask]
    @Query(sort: \RoutineTask.createdAt, order: .reverse) private var routineTasks : [RoutineTask]
    
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            LazyVStack(alignment: .leading, spacing: 12,){
                Section {
                    
                    if !todaysRoutines.isEmpty{
                        ForEach(todaysRoutines){ routine in
                            RoutineRow(routine: routine ,mode: .compact)
                                .swipeActions(edge: .trailing){
                                    Button{ }label:{
                                        Label("Complete", systemImage: "checkmark")
                                    }
                                    .tint(.green)
                                }
                        }
                    
                        if !todaysTasks.isEmpty{
                            ForEach(todaysTasks){ task in
                                TaskRow(task: task, mode: .compact)
                                    .swipeActions(edge: .trailing){
                                        Button{ }label:{
                                            Label("Complete", systemImage: "checkmark")
                                        }
                                        .tint(.green)
                                    }
                            }
                        }
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(GradientSectionBackground(viewStyle: .mainPage))
        .padding(.bottom,10)
    }
    
    private var todaysRoutines: [RoutineTask] {
        let todayIndex = Calendar.current.component(.weekday, from: Date())
        guard let today = WeekDay(rawValue: todayIndex) else { return [] }
        return routineTasks.filter { $0.routineDays.contains(today) }
    }
    
    private var todaysTasks : [DailyTask] { return dailyTasks.filter{ Calendar.current.isDate($0.date, inSameDayAs: Date()) } }

    // Liste Boşsa Çıkacak Görüntü
    private func EmptyStateView() -> some View {
        VStack(spacing: 10) {
            Image(systemName: "checklist")
                .font(.system(size: 40))
                .foregroundColor(.gray.opacity(0.5))
            Text("You’re free today 🎉")
                   .font(.subheadline)
                   .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 40)
    }
    

    
}
