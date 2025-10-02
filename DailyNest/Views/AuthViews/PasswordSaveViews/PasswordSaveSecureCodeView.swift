//
//  PasswordSaveSecureCodeView.swift
//  DailyNest
//
//  Created by Atakan İçel on 2.10.2025.
//

import SwiftUI

struct PasswordSaveSecureCodeView: View {
    @StateObject var viewModel : ForgotPasswordViewModel
    var onNext: (() -> Void)?
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    PasswordSaveSecureCodeView(viewModel: ForgotPasswordViewModel())
}
