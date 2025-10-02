//
//  PasswordSaveFlow.swift
//  DailyNest
//
//  Created by Atakan İçel on 2.10.2025.
//

enum PasswordSaveSteps {
    case mail
    case code
    case newPassword
}

import SwiftUI

struct PasswordSaveFlow: View {
    @StateObject private var viewModel = ForgotPasswordViewModel()
    @State private var stepIndex: Int = 0
    @State var currentStep: PasswordSaveSteps = .mail
    @State private var goLogin: Bool = false
    var body: some View {
        VStack(spacing: 20) {
            HStack() {
                Button(action: { previous() }){
                    Image(systemName: "chevron.left")
                    Text("Geri")
                        .padding(.leading,-8)
                }
                .padding(.leading, -30)
                StepIndicator(total: 3, currentIndex: stepIndex, style: .compact)
                    .padding(.horizontal)
                    .padding(.vertical,10)
                    .background(
                        Rectangle()
                            .fill(AppColors.icon.opacity(0.15))
                            .cornerRadius(20)
                    )
            }
            
            
            switch currentStep {
            case .mail:
                PasswordSaveMailView(viewModel: viewModel){ withAnimation{ next() } }
            case .code:
                PasswordSaveSecureCodeView(viewModel: viewModel){ withAnimation{ next() } }
            case .newPassword:
                PasswordSaveNewPasswordView(viewModel: viewModel){ withAnimation{ finish() } }
            }
            
            
            
            
        }
    }
    // MARK: - Flow Controls
    func next() {
        if currentStep == .mail {
            stepIndex = 1
            currentStep = .code
            print("step: \(stepIndex)")
        }else if currentStep == .code{
            stepIndex = 2
            currentStep = .newPassword
            print("step: \(stepIndex)")
        }
    }
    
    func previous() {
        if currentStep == .mail {
            goLogin.toggle()
        }
        else if currentStep == .code {
            stepIndex = 0
            currentStep = .mail
            print("step: \(stepIndex)")
        }else if currentStep == .newPassword{
            stepIndex = 1
            currentStep = .mail
            print("step: \(stepIndex)")
        }
    }
    
    func finish() {
        if currentStep == .newPassword {
            goLogin.toggle()
        }
    }
}
#Preview {
    PasswordSaveFlow()
}
