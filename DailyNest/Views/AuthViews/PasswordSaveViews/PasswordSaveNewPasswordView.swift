import SwiftUI

struct PasswordSaveNewPasswordView: View {
    @StateObject var viewModel = ForgotPasswordViewModel()
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    var isValid: Bool{ !password.isEmpty && password == confirmPassword }
    var body: some View {
        VStack(spacing: 20){
         
            Text("Şifre Kurtarma")
                .bold()
                .font(.title)
                .foregroundColor(AppColors.primaryText)
            
            Text("Lütfen yeni şifrenizi giriniz.")
                .font(.subheadline)
                .foregroundColor(AppColors.secondaryText)
                .fixedSize(horizontal: false, vertical: true)

            VStack(alignment:.leading){
             
                Text("Şifreniz:")
                    .opacity(0.6)
                    .font(.system(size: 16))
                SecureField("Şifrenizi giriniz:", text: $password)
                    .customSecureField()
                    .padding(.bottom)
                
                Text("Şifrenizi Doğrulayın:")
                    .opacity(0.6)
                    .font(.system(size: 16))
                SecureField("Şifrenizi giriniz:", text: $confirmPassword)
                    .customSecureField()
                    
            }
            
            Button(action: { },label: {
                Text("Yeni Şifre Belirle")
                    .bold()
                    .foregroundColor(.white)

            })
            .padding(.vertical, 14)
            .padding(.horizontal, 20)
            .frame(width: 250,height: 50)
            .background(isValid ? AppColors.button : Color.gray )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.white.opacity(0.1), lineWidth: 1)
            )
            .cornerRadius(16)
            .shadow(color: AppColors.accent.opacity(0.25), radius: 12, x: 0, y: 6)
            .disabled(!isValid)
 

        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(AppColors.background)
        
    }
}

#Preview {
    PasswordSaveNewPasswordView()
}
