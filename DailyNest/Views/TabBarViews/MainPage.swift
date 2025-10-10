import SwiftUI
import Combine
// NOTE: Arayüz büyük ölçüde bitti. ViewModel ile birlikte işlevsellikler yapıcak
// TODO: İşev atamaları viewmodelden sonra yapılacak. İşlevleri atarken, view kontrollerini yap. 

struct MainPage: View {
    @StateObject private var viewModel = MainPageViewModel()
    @State private var showRoutines: Bool = true
    @State private var showToDos: Bool = true
    var body: some View {
        
            VStack(alignment: .leading, spacing: 10) {
                GreetingsModule()
                    .padding(.leading,25)
                    .padding(.top, 10)
                
                ProgressCard(config: .forType(.allToDo))//verileri statik şu an, gerçek veriler girilince düzenlenmeli !
                    .padding(.horizontal,30)
                    .padding(.top, 10)
                
                //Kategori gidişleri
                HStack {
                    Spacer()
                    NavigationLink(destination: ToDoListView(mode: .dailyPage)){
                        Text("Günlük İşlerim")
                            .padding()
                            .font(.headline)
                            .foregroundColor(AppColors.primaryText)
                    }
                    .frame(width: 150, height: 50)
                    .background(ToDoButtonsBackgrounds(todoCategory: .daily))
                    Spacer()
                    
                    NavigationLink(destination: ToDoListView(mode: .routinePage)){
                        Text("Rutinlerim")
                            .font(.headline)
                            .padding()
                            .foregroundColor(AppColors.primaryText)
                        
                    }
                    .frame(width: 150, height: 50)
                    .background(ToDoButtonsBackgrounds(todoCategory: .routine))
                    Spacer()
                }
                
                Text("Bugünkü Görevlerim")
                    .font(.headline).bold()
                    .foregroundColor(AppColors.secondaryText)
                    .padding(.leading,20)
                
                //Görevlerim Kısımı
                VStack(spacing: 0) {
                    DailyTasksModule()
                        .padding(.horizontal)
                        .padding(.bottom, 60) // Yukarı taşıma
                    
                }
                .overlay(
                    NewToDoAddButtonView()
                        .padding(.trailing,8)
                        .padding(.bottom,50),
                    alignment: .bottomTrailing
                )//ZStack
                .navigationDestination(for: ToDo.self){ todo in ToDoDetailView(todo: todo) }
            }.background(AppColors.background)
        
    }//Body
}//Struct

#Preview {
    TabBarView()
}
