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
        if trait.userInterfaceStyle == .dark {
            // Dark mode: daha belirgin üst ışık efekti
            return UIColor(red: 55/255, green: 55/255, blue: 60/255, alpha: 1)
        } else {
            // Light mode: daha açık, "sayfa üstü" efekti
            return UIColor(red: 248/255, green: 248/255, blue: 252/255, alpha: 1)
        }
    })
    
    static let sectionBackgroundEnd = Color(UIColor { trait in
        if trait.userInterfaceStyle == .dark {
            // Dark mode: daha derin gölge efekti
            return UIColor(red: 25/255, green: 25/255, blue: 30/255, alpha: 1)
        } else {
            // Light mode: hafif gri alt ton, derinlik verir
            return UIColor(red: 232/255, green: 232/255, blue: 238/255, alpha: 1)
        }
    })
}
