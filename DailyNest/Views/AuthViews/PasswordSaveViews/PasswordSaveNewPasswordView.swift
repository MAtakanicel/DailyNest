//
//  PasswordSaveNewPasswordView.swift
//  DailyNest
//
//  Created by Atakan İçel on 2.10.2025.
//

import SwiftUI

struct PasswordSaveNewPasswordView: View {
    @StateObject var viewModel : ForgotPasswordViewModel
    var onComplite: (() -> Void)?
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    PasswordSaveNewPasswordView(viewModel: ForgotPasswordViewModel())
}
