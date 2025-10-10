import SwiftUI

enum ViewStyle{
    case mainPage
    case routinePage
    case dailyPage
}

struct GradientSectionBackground: View {
    @Environment(\.colorScheme) private var colorScheme
    let viewStyle: ViewStyle
    
    var body: some View {
        ZStack {
            switch viewStyle {
            case .mainPage:
                // MARK: - Ana yüzey
                RoundedRectangle(cornerRadius: 30)
                    .fill(backgroundFill)
                    .shadow(color: shadowColor, radius: 6, x: 0, y: 3)
                
                // MARK: - Üstten gelen soft light vurgusu (dark mod)
                if colorScheme == .dark {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(0.04),
                                    Color.clear
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .blendMode(.softLight)
                }
                
                // MARK: - Kenar vurgusu (dark modda zar zor fark edilir)
                RoundedRectangle(cornerRadius: 30)
                    .strokeBorder(
                        colorScheme == .dark
                        ? Color.white.opacity(0.05)
                        : Color.white.opacity(0.4),
                        lineWidth: 1.5
                    )
                    .blur(radius: 0.5)
                
            case .routinePage:
                if colorScheme == .light {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(
                            LinearGradient(colors: [.blue.opacity(0.07), .accentColor.opacity(0.04) ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing)
                        )
                        .shadow(color: .black.opacity(0.2), radius: 5)
                }else{
                    RoundedRectangle(cornerRadius: 30)
                        .fill(
                            LinearGradient(colors: [.blue.opacity(0.1), .accentColor.opacity(0.05) ],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color.white.opacity(0.1),lineWidth: 0.3)
                        )
                }
                
              
                
            case .dailyPage:
                if colorScheme == .light {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(
                            LinearGradient(colors: [.purple.opacity(0.06), .pink.opacity(0.03)],
                                           startPoint: .topLeading,
                                           endPoint: .bottomTrailing)
                        )
                        .shadow(color: .black.opacity(0.2), radius: 5)
                    
                }else{
                    RoundedRectangle(cornerRadius: 30)
                        .fill(
                            LinearGradient(colors: [.purple.opacity(0.04), .pink.opacity(0.02)],
                                           startPoint: .topLeading,
                                           endPoint: .bottomTrailing)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color.white.opacity(0.1),lineWidth: 0.3)
                        )
                }
                
            }
        }
    }

    // MARK: - Dynamic fill
    private var backgroundFill: AnyShapeStyle {
        if colorScheme == .dark {
            return AnyShapeStyle(
                Color(red: 28/255, green: 28/255, blue: 30/255)
            )
        } else {
            return AnyShapeStyle(
                LinearGradient(
                    colors: [
                        AppColors.sectionBackgroundEnd.opacity(0.9),
                        AppColors.sectionBackgroundStart.opacity(0.5),
                        Color.white.opacity(0.9)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
        }
    }

    private var shadowColor: Color {
        colorScheme == .dark
        ? Color.black.opacity(0.5)
        : Color.gray.opacity(0.25)
    }
}
#Preview {
    ToDoListView(mode: .dailyPage)
}
