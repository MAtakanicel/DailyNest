
import SwiftUI

enum AppComponents{
    case progressCard
}

struct CompanontBackgrounds: View {
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
        }
        
    }

}

#Preview {
    CompanontBackgrounds(component: .progressCard)
}
