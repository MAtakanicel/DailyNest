import Foundation
import SwiftUI

extension Button {
    func customButton(expand: Bool = true) -> some View {
        self.buttonStyle(CustomButtonStyle(expand: expand))
    }
}
