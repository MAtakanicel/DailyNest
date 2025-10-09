import SwiftUI

enum FloatingTab: String, CaseIterable {
    case home = "house.fill"
    case agenda = "calendar"
    case profile = "person.crop.circle.fill"
}

struct TabBarView: View {
    @State private var mainPagePath: [ToDo] = []
    @State private var selectedTab: FloatingTab = .home
    var body: some View {
            ZStack(alignment: .bottom) {
                
                // İçerik Alanı
                
                    switch selectedTab {
                        case .home: NavigationStack(path: $mainPagePath){
                            MainPage(path: $mainPagePath)
                        }
                        case .agenda: NavigationStack(){
                            AgendaView()
                        }
                        case .profile: NavigationStack(){
                            SettingsMainView()
                        }
                    }
                
                // Floating Tab Bar
                HStack {
                    tabButton(.home)
                    tabButton(.agenda)
                    tabButton(.profile)
                }
                .padding(.top, 12)
                .padding(.bottom, 15) // Alt boşluk
                .background(.ultraThinMaterial) // Blur efekt
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 6)
                .padding(.horizontal, 40)
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
