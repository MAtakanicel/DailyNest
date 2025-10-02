import SwiftUI

struct PasswordSaveMailView: View {
    @StateObject var viewModel : ForgotPasswordViewModel
    var onNext: (() -> Void)?
    
    @State var email: String = ""
    var body: some View {
        
        VStack(spacing: 20){
            
            Text("Şifre Kurtarma")
                .bold()
                .font(.title)
                .foregroundColor(AppColors.primaryText)
                .padding(.vertical, 40)
            
            Text("Lüften kurtarmak istediğiniz hesabın kayıtlı olduğu e-posta adresini giriniz. E-postanıza bir kod gönderilecektir.")
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
            Spacer()
            Button(action: { }, label: {
                Text("Kod Gönder")
            }).customButton()
                .frame(width: 250, height: 250)
            
            
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
