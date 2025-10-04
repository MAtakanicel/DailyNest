import SwiftUI
import UIKit

struct CustomTextField: View {
    let title: String
    @Binding var text: String
    let placeholder: String
    var isSecure: Bool = false
    var keyboardType: UIKeyboardType = .default
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(AppColors.secondaryText)
            
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text(placeholder)
                        .foregroundColor(AppColors.secondaryText.opacity(0.6))
                        .padding(.horizontal, 12)
                }
                if isSecure {
                    SecureField("", text: $text)
                        .focused($isFocused)
                        .padding(12)
                        .keyboardType(keyboardType)
                        .foregroundColor(AppColors.primaryText)
                        .tint(AppColors.accent)
                } else {
                    TextField("", text: $text)
                        .focused($isFocused)
                        .padding(12)
                        .keyboardType(keyboardType)
                        .foregroundColor(AppColors.primaryText)
                        .tint(AppColors.accent)
                }
            }
            .background(AppColors.secondaryBackground)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(isFocused ? AppColors.accent : AppColors.icon.opacity(0.25), lineWidth: 1)
            )
        }
    }
}

struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(12)
            .background(AppColors.secondaryBackground)
            .cornerRadius(10)
            .foregroundColor(AppColors.primaryText)
            .tint(AppColors.accent)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(AppColors.icon.opacity(0.25), lineWidth: 1)
            )
    }
}
// MARK: - Preview
#if DEBUG
struct CustomTextField_Previews: PreviewProvider {
    struct Wrapper: View {
        @State private var email: String = ""
        @State private var password: String = ""
        var body: some View {
            VStack(spacing: 16) {
                CustomTextField(title: "E-posta", text: $email, placeholder: "email@domain.com", isSecure: false, keyboardType: .emailAddress)
                CustomTextField(title: "Şifre", text: $password, placeholder: "•••••••", isSecure: true)
            }
            .padding()
            .background(AppColors.background)
        }
    }
    static var previews: some View {
        Group {
            Wrapper()
                .previewDisplayName("Light")
                .environment(\..colorScheme, .light)
            Wrapper()
                .previewDisplayName("Dark")
                .environment(\..colorScheme, .dark)
        }
    }
}
#endif
