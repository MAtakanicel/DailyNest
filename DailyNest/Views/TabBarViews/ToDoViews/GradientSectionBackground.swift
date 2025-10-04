import SwiftUI

struct GradientSectionBackground: View {
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        ZStack {
            // MARK: - 1️⃣ Derin gölge katmanı
            RoundedRectangle(cornerRadius: 20)
                .fill(innerShadowGradient)
                .blur(radius: 2)
                .offset(y: 1)
                .opacity(0.6)

            // MARK: - 2️⃣ Ana gradient yüzey
            RoundedRectangle(cornerRadius: 30)
                .fill(mainGradient)
                .shadow(color: shadowColor, radius: 8, x: 0, y: 4)

            // MARK: - 3️⃣ İç ışık kenar efekti (parlak veya koyu)
            RoundedRectangle(cornerRadius: 40)
                .strokeBorder(innerEdgeHighlight, lineWidth: 1)
                .blendMode(.overlay)
                .opacity(0.8)

            // MARK: - 4️⃣ Dış diffuse parıltı (yumuşak yüzey ışığı)
            RoundedRectangle(cornerRadius: 40)
                .strokeBorder(outerGlow, lineWidth: 1.2)
                .blur(radius: 6)
                .opacity(0.5)
        }
    }

    // MARK: - Gradients ve renkler

    /// Ana renk geçişi (light/dark’a göre ters kontrast)
    private var mainGradient: LinearGradient {
        if colorScheme == .dark {
            // 🌙 Dark: merkez koyu, köşeler açık
            return LinearGradient(
                colors: [
                    Color.white.opacity(0.03),
                    AppColors.sectionBackgroundStart,
                    AppColors.sectionBackgroundEnd
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        } else {
            // ☀️ Light: merkez açık, köşeler koyu
            return LinearGradient(
                colors: [
                    AppColors.sectionBackgroundEnd.opacity(0.9),
                    AppColors.sectionBackgroundStart.opacity(0.5),
                    Color.white.opacity(0.9)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
    }

    /// İç gölge efekti
    private var innerShadowGradient: LinearGradient {
        if colorScheme == .dark {
            return LinearGradient(
                colors: [Color.black.opacity(0.3), .clear],
                startPoint: .top,
                endPoint: .bottom
            )
        } else {
            return LinearGradient(
                colors: [Color.black.opacity(0.05), .clear],
                startPoint: .top,
                endPoint: .bottom
            )
        }
    }

    /// İç kenar parlaması (highlight)
    private var innerEdgeHighlight: Color {
        colorScheme == .dark
        ? Color.white.opacity(0.08)
        : Color.white.opacity(0.5)
    }

    /// Dış yumuşak parıltı (ambient glow)
    private var outerGlow: Color {
        colorScheme == .dark
        ? Color.white.opacity(0.05)
        : Color.gray.opacity(0.1)
    }

    /// Ana shadow
    private var shadowColor: Color {
        colorScheme == .dark
        ? Color.black.opacity(0.8)
        : Color.gray.opacity(0.235)
    }
}

#Preview {
    TabBarView()
}
