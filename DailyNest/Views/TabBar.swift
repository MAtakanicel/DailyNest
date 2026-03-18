//
//  TabBar.swift
//  DailyNest
//
//  Created by Atakan on 30.01.2026.
//

import SwiftData
import SwiftUI

enum FloatingTab: String, CaseIterable {
    case home = "house.fill"
    case routine = "repeat"
    case agenda = "calendar"
    case settings = "gear"
    case priority = "star.fill"
}

struct TabBar: View {
    @Environment(\.modelContext) private var context
    @Environment(SheetRouter.self) private var sheetRouter

    @Query private var dailyTasks: [DailyTask]
    @Query private var routineTasks: [RoutineTask]

    @State var selectedTab: FloatingTab = .home

    @Namespace private var tabBarAnimation

    var body: some View {
        @Bindable var router = sheetRouter
        
        ZStack(alignment: .bottom) {
            // İçerik Alanı
            Group {
                switch selectedTab {
                case .home: NavigationStack {
                        MainPage()
                    }
                case .routine: NavigationStack {
                        RoutinesView()
                    }
                case .agenda: NavigationStack {
                        Agenda()
                    }
                case .settings: NavigationStack {
                        SettingsView()
                    }
                case .priority: NavigationStack {
                        PriorityMatrixView()
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .safeAreaInset(edge: .bottom) {
                Color.clear.frame(height: 80) // TabBar yüksekliği kadar boşluk
            }
            .sheet(item: $router.activeSheet){ sheet in
                switch sheet{
                case .taskDetail(_): EmptyView()
                case .routineDetail(_): EmptyView()
                case .newDaily: EmptyView()
                case .newRoutine: EmptyView()
                }
            }
            // Floating Tab Bar
            HStack(spacing: 0) {
                tabButton(.home)
                tabButton(.routine)
                tabButton(.agenda)
                tabButton(.priority)
                tabButton(.settings)
            }
            .padding(.top, 10)
            .padding(.bottom, 10)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
            .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 6)
            .padding(.horizontal, 30)
            /* .overlay(alignment: .topTrailing){
                  NewTaskButton(mode: .daily, onTap: { })
                      .offset(x: -20 , y: -60)
              }
             */
        }
        .ignoresSafeArea(.keyboard)
        .onAppear {
            checkAndLoadMockData()
        }
    }

    /// Data Kontrol
    private func checkAndLoadMockData() {
        #if DEBUG
            if dailyTasks.isEmpty, routineTasks.isEmpty {
                MockData.shared.insertSampleData(modelContext: context)
                print("📦 Veritabanı mock data ile yüklendi.")
            }
        #endif
    }

    /// Tek tek tab butonu
    private func tabButton(_ tab: FloatingTab) -> some View {
        Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                selectedTab = tab
            }
        } label: {
            VStack(spacing: 4) {
                Image(systemName: tab.rawValue)
                    .font(.system(size: 25, weight: .medium)) // 30 ve semibold

                if selectedTab == tab {
                    Circle()
                        .fill(AppColors.button)
                        .frame(width: 5, height: 5)
                        .matchedGeometryEffect(id: "TabDot", in: tabBarAnimation) // Animasyon için namespace (Şimdilik basit)
                }
            }
            .foregroundColor(selectedTab == tab ? AppColors.button : .gray.opacity(0.8))
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    TabBar()
        .modelContainer(MockData.previewContainer)
        .environment(HomeViewModel())
        .environment(DailyViewModel())
        .environment(RoutineViewModel())
        .environment(SheetRouter())
}
