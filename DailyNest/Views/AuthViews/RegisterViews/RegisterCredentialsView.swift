import SwiftUI

struct RegisterCredentialsView: View {
    @StateObject var viewModel : RegisterViewModel
    var onComplete : (() -> Void)?
    @State private var eMail : String = ""
    @State private var password : String = ""
    @State private var confirmPassword : String = ""
    var isValid: Bool{ !password.isEmpty && password == confirmPassword && !eMail.isEmpty}
    @State private var isChecked : Bool = false
    @State private var KVKKViewIsShown : Bool = false
    @State private var privacyViewIsShown : Bool = false
    
    var body: some View {
        VStack(spacing: 20 ){
            //Başlık
            Text("Hesap Bilgileriniz")
                .bold()
                .font(.title2)
                .foregroundColor(AppColors.primaryText)
                .padding(.bottom, 5)
            
            //Subtitle
            Text("Lütfen e-posta adresinizi ve şifrenizi giriniz.")
                .font(.subheadline)
                .foregroundColor(AppColors.secondaryText)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.bottom,40)
            
            // Form
            VStack(alignment: .leading){
                    
                Text("E-posta adresiniz:")
                    .opacity(0.6)
                    .font(.system(size: 16))
                TextField("e-postanızı giriniz", text: $eMail)
                    .customTextField()
                    .padding(.bottom)
                    .keyboardType(.emailAddress)
                
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
                    .padding(.bottom)
                    
                
                HStack{
                    Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                                .resizable()
                                .frame(width: 18, height: 18)
                                .foregroundColor(isChecked ? AppColors.buttonTapped : AppColors.secondaryText)
                                .onTapGesture {
                                    isChecked.toggle()
                                }
                    
                    Button(action: { KVKKViewIsShown.toggle() } , label: {
                        Text("KVKK")
                            .font(.caption)
                            .foregroundColor(AppColors.button)
                            .bold()
                    })
                    
                    Text("ve")
                        .font(.caption)
                        .foregroundColor(AppColors.secondaryText)
                        
                    
                    Button(action: {privacyViewIsShown.toggle() }, label: {
                        Text("Gizlilik Politikasını")
                            .font(.caption)
                            .foregroundColor(AppColors.button)
                            .bold()
                    })
                    
                    Text("okudum ve kabul ediyorum.")
                        .font(.caption)
                        .foregroundColor(AppColors.secondaryText)

                }
                
            } //Form
            
            Spacer()
            Button(action: { },label: {
                Text("Başlayalım ")
                    .foregroundColor(.white)
                    .bold()
            
                + Text(" →")
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
 
            Spacer()
            
        } //Vstack
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(AppColors.background)
        
        //Prototip KVKK ve Privacy tam halinde değil. Düzenlenmeli.
        .sheet(isPresented: $KVKKViewIsShown, content: { DocumentView(fileName: "kvkk") })
        .sheet(isPresented: $privacyViewIsShown, content: { DocumentView(fileName: "privacy") })
        
    } //body
} //Struct

#Preview {
    //RegisterCredentialsView()
    RegisterFlowView(currentStep: .credentials)
}
