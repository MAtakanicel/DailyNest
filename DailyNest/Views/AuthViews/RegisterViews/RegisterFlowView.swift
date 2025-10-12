import SwiftUI

enum RegisterStep {
    case name
    case birthdate
    case credentials
}
struct RegisterFlowView: View {
    @State private var isPresented: Bool = false
    @StateObject private var viewModel = RegisterViewModel()
    @State private var stepIndex: Int = 0
    @State var currentStep: RegisterStep = .name
    @State private var goLogin: Bool = false
    
    var body: some View {
        VStack{
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
            case .name:
                RegisterNameView(viewModel: viewModel){
                    withAnimation{ next()}
                }
                
            case .birthdate:
                RegisterBirthView(viewModel: viewModel){
                    withAnimation{next()}
                }
                
            case .credentials:
                RegisterFinalView(viewModel: viewModel){
                    withAnimation{ finish()}
                }
            }
        }
        .padding(.top, 10)
        .background(AppColors.background)
        .fullScreenCover(isPresented: $isPresented,content: { }) //Bitiş
        .fullScreenCover(isPresented: $goLogin, content: { LoginView() }) //Geri
    }
    
    // MARK: - Flow Controls
    func next() {
        if currentStep == .name {
            stepIndex = 1
            currentStep = .birthdate
            print("step: \(stepIndex)")
        }else if currentStep == .birthdate{
            stepIndex = 2
            currentStep = .credentials
            print("step: \(stepIndex)")
        }
    }
    
    func previous() {
        if currentStep == .name {
            goLogin.toggle()
        }
        else if currentStep == .birthdate {
            stepIndex = 0
            currentStep = .name
            print("step: \(stepIndex)")
        }else if currentStep == .credentials{
            stepIndex = 1
            currentStep = .birthdate
            print("step: \(stepIndex)")
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
