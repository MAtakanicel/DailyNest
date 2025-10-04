import SwiftUI
struct CustomButtonStyle: ButtonStyle {
    var expand: Bool = true
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding(.vertical, 14)
            .padding(.horizontal, 20)
            .frame(maxWidth: expand ? .infinity : nil)
            .background(AppColors.button)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.white.opacity(0.1), lineWidth: 1)
            )
            .cornerRadius(16)
            .shadow(color: AppColors.accent.opacity(0.25), radius: 12, x: 0, y: 6)
            .opacity(configuration.isPressed ? 0.85 : 1)
    }
}
