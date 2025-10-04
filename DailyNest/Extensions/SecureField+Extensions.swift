import Foundation
import SwiftUI

extension SecureField {
    func customSecureField() -> some View {
        self
            .textFieldStyle(CustomTextFieldStyle())
            .padding(.bottom, 5)
            .frame(height: 50)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.black.opacity(0.2))
                        .offset(y: 2)
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
