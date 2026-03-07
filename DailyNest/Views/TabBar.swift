//
//  MainTabView.swift
//  DailyNest
//
//  Created by Atakan on 30.01.2026.
//

import SwiftUI
import SwiftData

enum FloatingTab: String, CaseIterable {
    case home = "house.fill"
    case agenda = "calendar"
    case settings = "gear"
}

struct TabBar: View {
    @Environment(\.modelContext) private var context
    
    @Query private var dailyTasks: [DailyTask]
    @Query private var routineTasks: [RoutineTask]

    @State private var selectedTab: FloatingTab = .home
    var body: some View {
            ZStack(alignment: .bottom) {
                
                // İçerik Alanı
                Group{
                    switch selectedTab {
                    case .home: NavigationStack{
                        MainPage()
                    }
                    case .agenda: NavigationStack(){
                        Agenda()
                    }
                    case .settings: NavigationStack(){
                        Settings()
                    }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
               
                .safeAreaInset(edge: .bottom) {
                    Color.clear.frame(height: 80) // TabBar yüksekliği kadar boşluk
                }
                
                // Floating Tab Bar
                HStack(spacing: 0) {
                    tabButton(.home)
                    tabButton(.agenda)
                    tabButton(.settings)
                }
                .padding(.top, 12)
                .padding(.bottom, 15) // Alt boşluk
                .background(.ultraThinMaterial) // Blur efekt
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 6)
                .padding(.horizontal, 40)
            }
            .ignoresSafeArea(.keyboard)
            .onAppear{
               checkAndLoadMockData()
            }
            
        
    }
    //Data Kontrol
    private func checkAndLoadMockData() {
            #if DEBUG
            if dailyTasks.isEmpty && routineTasks.isEmpty {
                MockData.shared.insertSampleData(modelContext: context)
                print("📦 Veritabanı mock data ile yüklendi.")
            }
            #endif
        }
    
    // Tek tek tab butonu
    private func tabButton(_ tab: FloatingTab) -> some View {
        Button {
            withAnimation(.spring(response: 0.3,dampingFraction: 0.7)){
                selectedTab = tab
            }
        } label: {
            VStack(spacing: 4) {
                Image(systemName: tab.rawValue)
                    .font(.system(size: 25, weight: .medium)) //30 ve semibold
                
                if selectedTab == tab{
                    Circle()
                        .fill(AppColors.button)
                        .frame(width: 5, height: 5)
                        .matchedGeometryEffect(id: "TabDot", in: Namespace().wrappedValue) //Animasyon için namespace (Şimdilik basit)
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
}
