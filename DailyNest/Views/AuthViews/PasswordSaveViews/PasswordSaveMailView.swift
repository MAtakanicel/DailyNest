import SwiftUI

struct PasswordSaveMailView: View {
    @StateObject var viewModel : ForgotPasswordViewModel
    var onNext: (() -> Void)?
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    PasswordSaveMailView(viewModel: ForgotPasswordViewModel())
}
