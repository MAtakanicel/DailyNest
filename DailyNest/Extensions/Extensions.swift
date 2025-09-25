import SwiftUI

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

extension Button {
    func customButton(expand: Bool = true) -> some View {
        self.buttonStyle(CustomButtonStyle(expand: expand))
    }
}


