//
//  MainPage.swift
//  DailyNest
//
//  Created by Atakan on 30.01.2026.
//

import SwiftData
import SwiftUI

struct MainPage: View {
    @AppStorage("userName") private var userName: String = ""
    
    @Environment(HomeViewModel.self) private var homeViewModel
    @Environment(DailyViewModel.self) private var dailyViewModel
    
    @Environment(\.modelContext) private var context
    @Query private var dailyTasks: [DailyTask]
    @Query private var routineTasks: [RoutineTask]

    @State private var showNamePopUp: Bool

    init() {
        let savedName = UserDefaults.standard.string(forKey: "userName") ?? ""
        _showNamePopUp = State(initialValue: savedName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
    }

    @State private var showNewDailySheet: Bool = false
    var body: some View {
        ZStack {
            AppColors.background.ignoresSafeArea()

            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 0) {
                    greetings

                    Spacer()

                    NewTaskButton(mode: .main) { showNewDailySheet.toggle() }
                }
                .padding(.horizontal, 20)

                ProgressCard(config: homeViewModel.createProgressCard(dailyTasks: dailyTasks, routineTasks: routineTasks, type: .allTasks))
                    .padding(.horizontal, 30)
                    .padding(.top, 10)

                // Görevlerim Kısımı
                ScrollView{
                    LazyVStack(spacing:0){
                        DailysSections(header: "Geçmiş Görevler", items: dailyViewModel.overdueDailys(dailyTasks))
                            .padding(.horizontal,20)
                            .padding(.bottom,20)
                        
                        DailysSections(header: "Today", items: dailyViewModel.todaysDailys(dailyTasks))
                            .padding(.horizontal,20)
                            .padding(.bottom,20)
                        
                        RoutineSection(items: routineTasks)
                            .padding(.horizontal,20)
                    }
                }

            }

            if showNamePopUp {
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
        .sheet(isPresented: $showNewDailySheet) {
            NewDailySheetView()
        }
    } // Body

    private var greetings: some View {
        VStack(alignment: .leading) {
            Text("\(homeViewModel.getDaytime())  \(userName) 👋")
                .font(.title2.bold())
                .foregroundColor(AppColors.primaryText)
                .padding(.bottom, 2)
                .padding(.top, 15)

            Text(homeViewModel.formattedDate())
                .font(.subheadline)
                .padding(.bottom, 1)
        }
    }

    private var welcomePopUp: some View {
        VStack(spacing: 16) {
            VStack(spacing: 4) {
                Text("Welcome to DailyNest")
                    .foregroundColor(AppColors.primaryText)
                    .font(.title2)
                    .bold()

                Text("What should we call you?")
                    .foregroundStyle(AppColors.secondaryText)
                    .font(.subheadline)
            }

            TextField("Adınız", text: $userName)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.systemGray6))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color(.systemGray4), lineWidth: 0.75)
                )
                .padding(.horizontal, 20)

            Button(action: {
                showNamePopUp.toggle()
            }) {
                Text("Continue")
                    .foregroundStyle(trimmeduserName.isEmpty ? .gray : AppColors.appleSignInText)
                    .font(.title3)
                    .padding(12)
            }
            .background(trimmeduserName.isEmpty ? Color.gray.opacity(0.2) : AppColors.appleSignInBackground.opacity(0.85))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .disabled(trimmeduserName.isEmpty)
        }
    }
    
    private var trimmeduserName: String {
        userName.trimmingCharacters(in: .whitespacesAndNewlines)
    }
} // Struct

#Preview {
    TabBar()
        .modelContainer(MockData.previewContainer)
        .environment(HomeViewModel())
        .environment(DailyViewModel())
        .environment(RoutineViewModel())
}
