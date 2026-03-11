//
//  MainPage.swift
//  DailyNest
//
//  Created by Atakan on 30.01.2026.
//

import SwiftUI
import SwiftData

struct MainPage: View {
    @AppStorage("userName") private var userName: String = ""
    @ObservedObject private var vm : HomeViewModel
    @ObservedObject private var dailyViewModel : DailyViewModel
    
    @Environment(\.modelContext) private var context
    @Query private var dailyTasks : [DailyTask]
    @Query private var routineTasks : [RoutineTask]
    
    @State private var showNamePopUp : Bool
    

    
    init(vm: HomeViewModel, dailyViewModel: DailyViewModel){
        self.vm = vm
        self.dailyViewModel = dailyViewModel
        
        let savedName = UserDefaults.standard.string(forKey: "userName") ?? ""
        _showNamePopUp = State(initialValue: savedName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
    }
    
    var body: some View {
        ZStack{
            AppColors.background.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 10) {
                
                HStack(spacing: 0) {
                    greetings
                    
                    Spacer()
                    
                    NewTaskButton(mode:.main, destination: NewDailySheetView(dailyViewModel: DailyViewModel()))
                    
                }
                .padding(.horizontal,20)
                
                ProgressCard(config: vm.createProgressCard(dailyTasks: dailyTasks, routineTasks: routineTasks, type: .allTasks))
                    .padding(.horizontal,30)
                    .padding(.top, 10)
                
                
                Text("Bugünkü Görevlerim")
                    .font(.headline).bold()
                    .foregroundColor(AppColors.secondaryText)
                    .padding(.leading,20)
                
                
                //Görevlerim Kısımı
                MainPageTaskList()
                    .padding(.horizontal)
                    .padding(.bottom, 60) // Yukarı taşıma
                
                
                
            }
            
            
            if showNamePopUp{
                Color.clear
                    .background(.ultraThinMaterial)
                    .ignoresSafeArea()
                
                welcomePopUp
                    .padding(.vertical)
                    .background(
                        RoundedRectangle(cornerRadius: 24)
                            .fill(Color(.systemBackground).opacity(0.75))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                    )
                    .padding(25)
                
                
            }
        }
        
    }//Body
    
    private var greetings : some View {
        VStack(alignment: .leading){
            Text("\(vm.getDaytime())  \(userName) 👋")
                .font(.title2.bold())
                .foregroundColor(AppColors.primaryText)
                .padding(.bottom,2)
                .padding(.top,15)
            
            Text(vm.updateDate())
                .font(.subheadline)
                .padding(.bottom,1)
        }
    }
    
    private var welcomePopUp : some View {
        VStack(spacing: 16){
            VStack(spacing: 4){
                Text("Welcome to DailyNest")
                    .foregroundColor(AppColors.primaryText)
                    .font(.title2)
                    .bold()
                
                Text("What should we call you?")
                    .foregroundStyle(AppColors.secondaryText)
                    .font(.subheadline)
            }
            
            TextField("Adınız",text: $userName)
                .padding(.horizontal,16)
                .padding(.vertical,12)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.systemGray6))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color(.systemGray4), lineWidth: 0.75)
                )
                .padding(.horizontal,20)
            
            Button(action: {
                showNamePopUp.toggle()
            }){
                Text("Continue")
                    .foregroundStyle(userName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? .gray : AppColors.appleSignInText)
                    .font(.title3)
                    .padding(12)
            }
            .background(userName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? Color.gray.opacity(0.2) : AppColors.appleSignInBackground.opacity(0.85) )
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .disabled(userName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
        }
    }
    
}//Struct

#Preview {
    TabBar(homeViewModel: HomeViewModel(),dailyViewModel: DailyViewModel(),routineViewModel: RoutineViewModel())
        .modelContainer(MockData.previewContainer)
}
