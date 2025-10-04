import SwiftUI

//MARK: - TextField
extension TextField {
    func customTextField() -> some View {
        self
            .textFieldStyle(CustomTextFieldStyle())
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .padding(.bottom, 5)
            .frame(height: 50)
            .background(
                ZStack {
                    // Gölge
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.black.opacity(0.2))
                        .offset(y: 2)
                    // Arkaplan
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white.opacity(0.15))
                }
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
            )
    }
}

// MARK: - SecureField
extension SecureField {
    func customSecureField() -> some View {
        self.textFieldStyle(CustomTextFieldStyle())
            .padding(.bottom, 5)
            .frame(height: 50)
            .background(
                ZStack {
                    // Gölge
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.black.opacity(0.2))
                        .offset(y: 2)
                    
                    // Arkaplan
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white.opacity(0.15))
                }
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
            )
    }
}

// MARK: - Button (AUTH)
extension Button {
    func customButton(expand: Bool = true) -> some View {
        self.buttonStyle(CustomButtonStyle(expand: expand))
    }
}

// MARK: - Section Background Colors
extension AppColors {
    static let sectionBackgroundStart = Color(UIColor { trait in
        trait.userInterfaceStyle == .dark
        ? UIColor(red: 40/255, green: 40/255, blue: 45/255, alpha: 1)
        : UIColor(red: 240/255, green: 240/255, blue: 245/255, alpha: 1)
    })
    
    static let sectionBackgroundEnd = Color(UIColor { trait in
        trait.userInterfaceStyle == .dark
        ? UIColor(red: 30/255, green: 30/255, blue: 35/255, alpha: 1)
        : UIColor(red: 230/255, green: 230/255, blue: 240/255, alpha: 1)
    })
}
