import SwiftUI

struct GreetingsModule: View {
    @StateObject private var viewModel = MainPageViewModel()
    var body: some View {
        
        VStack(alignment: .leading){
            Text("\(viewModel.getDaytime())  \(viewModel.userName) 👋")
                .font(.title.bold())
                .foregroundColor(AppColors.primaryText)
                .padding(.bottom,2)
                .padding(.top,15)
            
            Text(viewModel.updateDate())
                .font(.subheadline)
                .padding(.bottom,1)
        }
    }
    

    
}

#Preview {
    TabBarView()
}
