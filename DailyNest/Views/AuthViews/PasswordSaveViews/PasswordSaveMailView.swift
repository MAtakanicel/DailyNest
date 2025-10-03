import SwiftUI

struct PasswordSaveMailView: View {
    @StateObject var viewModel : ForgotPasswordViewModel
    @State var email: String = ""
    var body: some View {
        
        VStack(spacing: 20){
            
            Text("Şifre Kurtarma")
                .bold()
                .font(.title)
                .foregroundColor(AppColors.primaryText)
                .padding(.vertical, 40)
            
            Text("Lüften kurtarmak istediğiniz hesabın kayıtlı olduğu e-posta adresini giriniz. E-postanıza bir şifre kurtarma linki gönderilecektir.")
                .font(.subheadline)
                .foregroundColor(AppColors.secondaryText)
                .fixedSize(horizontal: false, vertical: true)
            
            Spacer()
     
            VStack(alignment: .leading) {
                Text("E-Posta:")
                TextField("E-posta adresiniz.",text: $email)
                    .customTextField()
                    .keyboardType(.emailAddress)
            }
            
  
            Spacer()
            Button(action: {  }, label: {
                Text("Link Gönder")
            }).customButton()
                .frame(width: 250, height: 50)
            
            
            Spacer()
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(AppColors.background)
        
    }
}

#Preview {
    PasswordSaveMailView(viewModel: ForgotPasswordViewModel())
}
