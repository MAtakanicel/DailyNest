
import SwiftUI

enum AppComponents{
    case progressCard
    case toDoCellComplited
    case toDoCellNotComplited
}

struct CompanentBackgrounds: View {
    @Environment(\.colorScheme) private var colorScheme
    let component : AppComponents
    var body: some View {
        
        switch component {
            
        case .progressCard:
            if colorScheme == .light {
                RoundedRectangle(cornerRadius: 16)
                    .fill(.white.opacity(0.5))
                    .shadow(color: .black.opacity(0.2), radius: 6,x: 0, y: 3)
            }else{
                RoundedRectangle(cornerRadius: 16)
                    .fill(.white.opacity(0.05))
                    .shadow(color: .black.opacity(0.2), radius: 6,x: 0, y: 3)
            }
            
        case .toDoCellComplited:
            if colorScheme == .light{
                Color.black.opacity(0.05)
            }else{
                Color.white.opacity(0.03)
            }
        case .toDoCellNotComplited:
            if colorScheme == .light{
                Color.white.opacity(0.8)
            }else{
                Color.white.opacity(0.085)
            }
        }
        
    }

}

#Preview {
    ToDoListView(mode: .dailyPage)
}
