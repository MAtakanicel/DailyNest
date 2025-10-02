import SwiftUI

struct PasswordSaveMailView: View {
    @StateObject var viewModel : ForgotPasswordViewModel
    var onNext: (() -> Void)?
    
    @State var email: String = ""
    var body: some View {
        
        VStack(spacing: 20){
            Spacer()
            Text("Şifre Kurtarma")
                .bold()
                .font(.title)
                .foregroundColor(AppColors.primaryText)
                .padding(.bottom, 40)
            
            Text("Lüften kurtarmak istediğiniz hesabın kayıtlı olduğu e-posta adresini giriniz. E-postanıza bir kod gönderilecektir.")
                .font(.subheadline)
                .foregroundColor(AppColors.secondaryText)
                .fixedSize(horizontal: false, vertical: true)
            //    .padding(.bottom,70)
            Spacer()
     
            VStack(alignment: .leading) {
                Text("E-Posta:")
                TextField("E-posta adresiniz.",text: $email)
                    .customTextField()
                    .keyboardType(.emailAddress)
            }
            //.padding(.bottom,75)
            Spacer()
            Spacer()
            Button(action: { }, label: {
                Text("Kod Gönder")
            }).customButton()
            
            
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
