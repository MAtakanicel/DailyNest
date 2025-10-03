import SwiftUI

struct RegisterBirthGenderView: View {
    @StateObject var viewModel : RegisterViewModel
    @State private var birthDay: Date = {
        var components = DateComponents()
        components.year = 1990
        components.month = 1
        components.day = 1
        return Calendar.current.date(from: components) ?? Date()
    }()
    var onNext: (() -> Void)?
    var body: some View {
        VStack(spacing: 20){
            
            //Başlık
            Text("Doğum Tarihi")
                .bold()
                .font(.title2)
                .foregroundColor(AppColors.primaryText)
                .padding(.bottom, 5)
            
            //Bilgilendirme
            Text("Yaşınızı doğrulamak için lütfen doğum tarihinizi giriniz.")
                .font(.subheadline)
                .foregroundColor(AppColors.secondaryText)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.bottom,40)
            
            //Tarih
            DatePicker("",selection: $birthDay, displayedComponents: .date)
                .datePickerStyle(.wheel)
                .labelsHidden()
                
          Spacer()
            HStack {
                Spacer()
                Button(action: {onNext?()}){
                    Text("Sonraki Adıma geç") + Text(" →")
                }.customButton()
                    .frame(width: 250,height: 250)
                Spacer()
            }
            Spacer()
        } // Vstack
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(AppColors.background)
    } //body
} //Struct

#Preview {
    //RegisterBirthGenderView(viewModel: RegisterViewModel())
    RegisterFlowView(currentStep: .birthdate)
    
}
