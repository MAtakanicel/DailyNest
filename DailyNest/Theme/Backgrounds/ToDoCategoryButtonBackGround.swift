
import SwiftUI

enum ToDoCategory{
    case routine
    case daily
    case row
}

struct ToDoButtonsBackgrounds: View {
    @Environment(\.colorScheme) private var colorScheme
    let todoCategory: ToDoCategory
    var body: some View {
        
        switch todoCategory {
        case .routine:
            if colorScheme == .light{
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        LinearGradient(colors: [AppColors.progressGreen.opacity(0.2),.mint.opacity(0.05)],
                                       startPoint: .leading,
                                       endPoint: .trailing)
                    )
                    .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 2)
            }else{
                RoundedRectangle(cornerRadius: 16)
                    .fill(LinearGradient(colors: [AppColors.progressGreen.opacity(0.4),.mint.opacity(0.15)],
                                         startPoint: .leading,
                                         endPoint: .trailing)
                    ).overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.white.opacity(0.1),lineWidth: 2)
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
                    .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 2)
            }else{
                RoundedRectangle(cornerRadius: 16)
                    .fill(
                        LinearGradient(colors: [.purple.opacity(0.4),.pink.opacity(0.3) ],
                                       startPoint: .leading,
                                       endPoint: .trailing)
                    ).overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.white.opacity(0.1),lineWidth: 2)
                    )
            }
            
        case .row:
            if colorScheme == .light{
                LinearGradient(colors: [.purple.opacity(0.2),.mint.opacity(0.15)],
                               startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 2)
            }else{
                LinearGradient(colors: [.purple.opacity(0.25), .mint.opacity(0.15)], startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.white.opacity(0.1),lineWidth: 2)
                )
            }
            
            
        }
       
    }
}

struct ToDoCategoryButtonBackGrounds_Previews : PreviewProvider {
    static var todo : [ToDo] = MockData.mockData
    static var previews: some View {
    
        MainPage()
        
    }
    
}

