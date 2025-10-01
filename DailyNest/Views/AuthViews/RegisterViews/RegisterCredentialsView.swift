import SwiftUI

struct RegisterCredentialsView: View {
    @State var viewModel : RegisterViewModel
    var onComplete : (() -> Void)?
    @State private var eMail : String = ""
    @State private var password : String = ""
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
                
                Text("Şifreniz:")
                    .opacity(0.6)
                    .font(.system(size: 16))
                TextField("Şifrenizi giriniz:", text: $password)
                    .customTextField()
                    .padding(.bottom)
                
            } //Form
            
            Spacer()
            
            Button(action:{ }){
                Text("Başlayalım ") + Text(" →")
                    .bold()
                    
            }
            .customButton()
            .frame(width: 250, height: 50)
            
            Spacer()
            
        } //Vstack
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(AppColors.background)
    } //body
} //Struct

#Preview {
    //RegisterCredentialsView()
    RegisterFlowView(currentStep: .credentials)
}
