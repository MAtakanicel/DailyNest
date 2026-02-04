//
//  MainPage.swift
//  DailyNest
//
//  Created by Atakan on 30.01.2026.
//

import SwiftUI
import SwiftData
import Combine

struct MainPage: View {
    @StateObject private var vm = HomeViewModel()
    
    @Environment(\.modelContext) private var context
    @Query private var dailyTasks : [DailyTask]
    @Query private var routineTasks : [RoutineTask]
    
    @State private var showRoutines: Bool = true
    @State private var showToDos: Bool = true
    var body: some View {
        
            VStack(alignment: .leading, spacing: 10) {
                
                HStack(spacing: 0) {
                    GreetingsModule(greeting: vm.getDaytime(), userName: vm.userName, dateString: vm.updateDate())
                    
                    Spacer()
                    
                    Button(action: { }) {
                        Image(systemName: "bell")
                            .foregroundColor(.blue)
                            .font(.system(size: 22))
                    }

                    
                }
                .padding(.horizontal,20)
                
                ProgressCard(config: vm.createProgressCard(dailyTasks: dailyTasks, routineTasks: routineTasks, type: .allTasks))
                    .padding(.horizontal,30)
                    .padding(.top, 10)
                
                //Kategori gidişleri
                HStack {
                    Spacer()
                    NavigationLink(destination: TaskListView(vm: vm, mode: .dailyPage)){
                        Text("Günlük İşlerim")
                            .padding()
                            .font(.headline)
                            .foregroundColor(AppColors.primaryText)
                    }
                    .frame(width: 150, height: 50)
                    .background(ToDoButtonsBackgrounds(todoCategory: .daily))
                    Spacer()
                    
                    NavigationLink(destination: TaskListView(vm: vm, mode: .routinePage)){
                        Text("Rutinlerim")
                            .font(.headline)
                            .padding()
                            .foregroundColor(AppColors.primaryText)
                        
                    }
                    .frame(width: 150, height: 50)
                    .background(ToDoButtonsBackgrounds(todoCategory: .routine))
                    Spacer()
                }
                
                Text("Bugünkü Görevlerim")
                    .font(.headline).bold()
                    .foregroundColor(AppColors.secondaryText)
                    .padding(.leading,20)
                
                //Görevlerim Kısımı
                VStack(spacing: 0) {
                    MainPageTaskList()
                        .padding(.horizontal)
                        .padding(.bottom, 60) // Yukarı taşıma

                }
           /*     .overlay(
                    NewToDoAddButton()
                        .padding(.trailing,8)
                        .padding(.bottom,50),
                    alignment: .bottomTrailing
                )*/
               
            }.background(AppColors.background)
            
        
    }//Body
}//Struct

#Preview {
    MainPage()
        .modelContainer(MockData.previewContainer)
}
