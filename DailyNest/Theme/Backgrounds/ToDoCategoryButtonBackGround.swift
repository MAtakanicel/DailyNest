
import SwiftUI

enum ToDoCategory{
    case routine
    case daily
}

struct ToDoCategoryButtonBackGround: View {
    @Environment(\.colorScheme) private var colorScheme
    @State var todoCategory: ToDoCategory
    var body: some View {
        
        switch todoCategory {
        case .routine:
            if colorScheme == .light{
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        LinearGradient(colors: [.blue.opacity(0.2), .accentColor.opacity(0.05)],
                                       startPoint: .leading,
                                       endPoint: .trailing)
                    )
                    .shadow(color: .black.opacity(0.05), radius: 3, x: 0, y: 2)
            }else{
                RoundedRectangle(cornerRadius: 16)
                    .fill(LinearGradient(colors: [.blue.opacity(0.35),.accentColor.opacity(0.2)],
                                         startPoint: .leading,
                                         endPoint: .trailing)
                    ).overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.white.opacity(0.05))
                    )
            }
            
            
        case .daily:
            if colorScheme == .light{
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        LinearGradient(colors: [.purple.opacity(0.15), .pink.opacity(0.05)],
                                       startPoint: .leading,
                                       endPoint: .trailing)
                    )
                    .shadow(color: .black.opacity(0.05), radius: 3, x: 0, y: 2)
            }else{
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        LinearGradient(colors: [.purple.opacity(0.4),.pink.opacity(0.3) ],
                                       startPoint: .leading,
                                       endPoint: .trailing)
                    ).overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.white.opacity(0.05))
                    )
            }
        }
       
    }
}

#Preview {
    ToDoCategoryButtonBackGround(todoCategory: .routine)
}
