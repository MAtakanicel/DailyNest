import SwiftUI

enum FloatingTab: String, CaseIterable {
    case home = "house.fill"
    case agenda = "calendar"
    case profile = "person.crop.circle.fill"
}

struct TabBarView: View {
    @State private var selectedTab: FloatingTab = .home
    @State private var path: [ToDo] = []
    var body: some View {
        NavigationStack(path: $path) {
            ZStack(alignment: .bottom) {
                
                // İçerik Alanı
               
                    switch selectedTab {
                    case .home: ToDoListView(path: $path)
                    case .agenda: AgendaView()
                    case .profile: SettingsMainView()
                    }
                
               

                
                // Floating Tab Bar
                HStack {
                    tabButton(.home)
                    tabButton(.agenda)
                    tabButton(.profile)
                }
                .padding(.horizontal, 20)
                .padding(.top, 12)
                .padding(.bottom, 20) // Alt boşluk
                .background(.ultraThinMaterial) // Blur efekt
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 6)
                .padding(.horizontal, 24)
            }
            
        }
    }
    
    // Tek tek tab butonu
    private func tabButton(_ tab: FloatingTab) -> some View {
        Button {
            selectedTab = tab
        } label: {
            VStack {
                Image(systemName: tab.rawValue)
                    .font(.system(size: 30, weight: .semibold))
            }
            .foregroundColor(selectedTab == tab ? AppColors.button : .gray)
            .frame(maxWidth: .infinity)
        }
    }

}

#Preview {
    TabBarView()
}
