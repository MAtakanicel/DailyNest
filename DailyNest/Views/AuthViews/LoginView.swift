import SwiftUI
struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var goRegister: Bool = false
    @State private var goPasswordSave : Bool = false
    var isValid: Bool {
        !email.isEmpty && !password.isEmpty
    }
    var body: some View {
     
            VStack(spacing: 20){
                Image(.icon)
                    .resizable()
                    .frame(width: 250, height: 250)
                
                Text("Hoş Geldiniz")
                    .bold()
                    .font(.title)
                    .foregroundColor(AppColors.primaryText)
                
                
                
                Text("Giriş yapabilirsiniz.")
                    .bold()
                    .font(.system(size: 18))
                    .foregroundColor(AppColors.secondaryText)
                
                Spacer()
                
                VStack(alignment: .trailing){
                    
                    TextField("E posta", text: $email)
                        .customTextField()
                        .keyboardType(.emailAddress)
                        .padding(.bottom,10)
                    
                    
                    SecureField("Şifre", text: $password)
                        .customSecureField()
                        .padding(.bottom, 5)
                    
                    
                    Button(action: {  goPasswordSave.toggle()  }){
                        Text("Şifremi unuttum?")
                            .foregroundColor(AppColors.secondaryText)
                    }
                }.padding(.horizontal,20)
                
                Spacer()
                Button(action:{ }){
                    Text("Giriş Yap")
                }.customButton()
                    .frame(width: 250, height: 50)
                    .disabled(!isValid)
                
                HStack{
                    Text("Hesabın yok mu ?")
                    
                    Button(action: { goRegister.toggle() }){
                        Text("Kayıt ol.")
                            .foregroundColor(Color.accentColor)
                    }
                }.padding(.top,-5)
                
                Spacer()
            } //VStack
            .background(AppColors.background)
            
            .fullScreenCover(isPresented: $goRegister){
                RegisterFlowView()
            }
            
            .fullScreenCover(isPresented: $goPasswordSave, content: { PasswordSaveMailView(viewModel: ForgotPasswordViewModel()) })
        
    }
}

#Preview {
    LoginView()
}
