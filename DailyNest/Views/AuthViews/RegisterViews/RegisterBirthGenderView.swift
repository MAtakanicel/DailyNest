import SwiftUI

struct RegisterBirthGenderView: View {
    @State var viewModel : RegisterViewModel
    var onNext: (() -> Void)?
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    RegisterBirthGenderView(viewModel: RegisterViewModel())
}
