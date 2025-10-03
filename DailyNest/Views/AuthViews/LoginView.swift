import SwiftUI
import Combine

struct LoginView: View {
    @StateObject private var keyboard = KeyboardObserver()
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var goRegister: Bool = false
    @State private var goPasswordSave : Bool = false
    var isValid: Bool {
        !email.isEmpty && !password.isEmpty
    }
    var body: some View {
     
        NavigationStack {
            VStack(spacing: 20){
                Image(.icon)
                    .resizable()
                    .frame(width: 250, height: 250)
                if !keyboard.isKeyboardVisible{
                    Text("DailyNest")
                        .bold()
                        .font(.title)
                        .foregroundColor(AppColors.primaryText)
                        .padding(.bottom,20)
                        .padding(.top,-50)
               
             
                    Text("Kişisel Ajandanıza Hoş Geldiniz.")
                        .bold()
                        .font(.title3)
                        .foregroundColor(AppColors.primaryText)
                    
                    Spacer()
                }
               
                
                VStack(alignment: .trailing){
                    
                    TextField("E posta", text: $email)
                        .customTextField()
                        .keyboardType(.emailAddress)
                        .padding(.bottom,10)
                    
                    SecureField("Şifre", text: $password)
                        .customSecureField()
                        .padding(.bottom, 5)
                    
                    NavigationLink("Şifremi unuttum?"){
                        PasswordSaveMailView(viewModel: ForgotPasswordViewModel())
                    }
                    .foregroundColor(AppColors.secondaryText)
                    
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
        }
            
            
        
    }
}

#Preview {
    LoginView()
}
