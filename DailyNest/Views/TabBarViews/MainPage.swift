import SwiftUI
import Combine

struct MainPage: View {
    @StateObject private var viewModel = ToDoViewModel()
    @State private var showRoutines: Bool = true
    @State private var showToDos: Bool = true
    @Binding var path : [ToDo]
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            
            ToDoListHeader()
                .padding(.leading,25)
                .padding(.top, 10)
            
            ProgressCard()//verileri statik şu an, gerçek veriler girilince düzenlenmeli !
                .padding(.horizontal,30)
                .padding(.top, 10)
           
            //Kategori gidişleri
            HStack {
                Spacer()
                NavigationLink(destination: ToDoListView()){
                    Text("Günlük İşlerim")
                        .padding()
                        .font(.headline)
                        .foregroundColor(AppColors.primaryText)
                }
                .frame(width: 150, height: 50)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(
                            LinearGradient(colors: [.blue.opacity(0.15), .purple.opacity(0.1)],
                                           startPoint: .topLeading,
                                           endPoint: .bottomTrailing)
                        )
                        .shadow(color: .black.opacity(0.05), radius: 3, x: 0, y: 2))
                
                NavigationLink(destination: ToDoListView()){
                    Text("Rutinlerim")
                        .font(.headline)
                        .padding()
                        .foregroundColor(AppColors.primaryText)
 
                }
                .frame(width: 150, height: 50)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(
                            LinearGradient(colors: [.blue.opacity(0.15), .purple.opacity(0.1)],
                                           startPoint: .topLeading,
                                           endPoint: .bottomTrailing)
                        )
                        .shadow(color: .black.opacity(0.05), radius: 3, x: 0, y: 2))

                Spacer()
            }
           
            Text("Bugünkü Görevlerim")
                .font(.headline).bold()
                .foregroundColor(AppColors.secondaryText)
                .padding(.leading,20)
            
            //Görevlerim Kısımı
            VStack(spacing: 0) {
                DailyTasksModule(path: $path)
                    .padding(.horizontal)
                    .padding(.bottom, 60) // Yukarı taşıma
            }
            .overlay(
                NewToDoAddButtonView()
                    .padding(.trailing,5)
                    .padding(.bottom,60),
                alignment: .bottomTrailing
            )//ZStack
            .background(AppColors.background)
            .navigationDestination(for: ToDo.self){ todo in ToDoDetailView(todo: todo) }
        }.background(AppColors.background)
    }//Body
}//Struct

#Preview {
    TabBarView()
}
