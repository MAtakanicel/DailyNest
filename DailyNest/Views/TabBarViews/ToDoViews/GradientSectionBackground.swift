import SwiftUI

struct GradientSectionBackground: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(
                LinearGradient(
                    colors: [
                        AppColors.sectionBackgroundStart,
                        AppColors.sectionBackgroundEnd
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .shadow(color: .black.opacity(0.15), radius: 6, x: 0, y: 3)
    }
}
