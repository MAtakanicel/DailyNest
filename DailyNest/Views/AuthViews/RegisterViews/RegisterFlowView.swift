import SwiftUI

enum RegisterStep {
    case name
    case birthdate
    case credentials
}
struct RegisterFlowView: View {
    @State private var isPresented: Bool = false
    @StateObject private var viewModel = RegisterViewModel()
    @State var stepIndex: Int = 0
    @State private var currentStep: RegisterStep = .name
    var totalSteps: Int = 3
    
    
    var body: some View {
        VStack{
        StepIndicator(total: totalSteps, currentIndex: stepIndex, style: .compact)
            .padding(.horizontal)
            .padding(.vertical,10)
            .background(
                Rectangle()
                    .fill(AppColors.icon.opacity(0.15))
                    .cornerRadius(20)
            )
            
            switch currentStep {
            case .name:
                RegisterNameView(viewModel: viewModel){
                    withAnimation{currentStep = .birthdate}
                }
                
            case .birthdate:
                RegisterBirthGenderView(viewModel: viewModel){
                    withAnimation{currentStep = .credentials}
                }
                
            case .credentials:
                RegisterCredentialsView()
            }
        }
        .padding(.top, 10)
        .background(AppColors.background)
            .fullScreenCover(isPresented: $isPresented) {
                
            }
    }
    
    // MARK: - Flow Controls
    func next() {
        if currentStep == .name {
            stepIndex += 1
            currentStep = .birthdate
        }else if currentStep == .birthdate{
            stepIndex += 1
            currentStep = .credentials
        }
    }
    
    func previous() {
        if currentStep == .birthdate {
            stepIndex -= 1
            currentStep = .name
        }else if currentStep == .credentials{
            stepIndex -= 1
            currentStep = .birthdate
        }
    }
    
    func finish() {
        if currentStep == .credentials {
            isPresented = true
        }
    }

}

#if DEBUG
#Preview {
    RegisterFlowView()
}
#endif
