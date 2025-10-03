import SwiftUI

struct RegisterNameView: View {
    // Geçici durumlar; ViewModel ile bağlamak için dışarıdan Binding veya EnvironmentObject eklenebilir
    @StateObject var viewModel :RegisterViewModel
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    var onNext: (() -> Void)?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
          HStack{
                Spacer()
                // Başlık
                Text("Adınız ve Soyadınız")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(AppColors.primaryText)
                Spacer()
            }
          
            // Bilgilendirme metni
            Text("Merhaba, deneyiminizi size özel hale getirmek için isminizi istiyoruz.")
                .font(.subheadline)
                .foregroundColor(AppColors.secondaryText)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.bottom,40)
            // Ad ve Soyad
            VStack(alignment: .leading, spacing: 8) {
                Text("İsminiz:")
                    .opacity(0.6)
                    .font(.system(size: 16))
                TextField("İsminizi giriniz", text: $firstName)
                    .customTextField()
                    .padding(.bottom)
               
                    
                Text("Soyisminiz:")
                    .opacity(0.6)
                    .font(.system(size: 16))
                TextField("Soyisminizi giriniz", text: $lastName)
                    .customTextField()
    
            }
            
            // Gizlilik notu
            Text("Merak etmeyin isminizi ve kişisel bilgileriniz kimseyle paylaşılmaz.")
                .font(.footnote)
                .foregroundColor(AppColors.secondaryText)
                .padding(.top, 4)
            
            Spacer()
            // Sonraki adım butonu
            HStack {
                Spacer()
                Button(action: {onNext?()}){
                    Text("Sonraki Adıma geç") + Text(" →")
                }.customButton()
                    .frame(width: 250,height: 250)
                Spacer()
            }
            .padding(.top, 8)
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(AppColors.background)
    }
    

    
}

#if DEBUG
#Preview {
   RegisterNameView(viewModel: RegisterViewModel())

}
#endif
