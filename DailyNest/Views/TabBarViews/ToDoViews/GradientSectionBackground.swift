import SwiftUI

struct GradientSectionBackground: View {
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        ZStack {
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
    TabBarView()
}
