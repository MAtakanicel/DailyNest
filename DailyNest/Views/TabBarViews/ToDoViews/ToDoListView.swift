
import SwiftUI

enum Mode{
    case routinePage
    case dailyPage
}

struct ToDoListView: View {
    @StateObject private var toDoViewModel = ToDoViewModel()
    @StateObject private var mainPageViewModel = MainPageViewModel()
    let mode: Mode
    var body: some View {
            VStack(alignment:.leading,spacing: 10){
                
                switch mode {
                case .routinePage:
                    HStack(alignment: .center) {
                        Text("Buradan tüm rutinlerinizi görebilirsiniz.")
                            .font(.subheadline)
                            .foregroundColor(AppColors.secondaryText)
                            
                    }
                    
                    ScrollView{
                        LazyVStack{
                            Section{
                                ForEach(toDoViewModel.todos){ todo in
                                    ToDoRow(todo: todo,mode: .detailed)
                                        .padding(.bottom, 5)
                                }
                            }
                        }
                    }
                    .padding()
                    .background(GradientSectionBackground(viewStyle: .routinePage))
                    
                case .dailyPage:
                    
                    
                    ScrollView{
                        LazyVStack{
                            Section{
                                ForEach(toDoViewModel.todos){ todo in
                                    ToDoRow(todo: todo,mode: .detailed)
                                        .padding(.bottom, 5)
                                }
                            }
                        }
                    }
                    .padding()
                    .background(GradientSectionBackground(viewStyle: .dailyPage))
                    
                }
                
            }
            .padding()
            .padding(.vertical, 20)
            .background(AppColors.background)
            .toolbar{
                ToolbarItem(placement: .principal){
                    
                    switch mode {
                    case .routinePage:
                        Text("Rutinlerim")
                            .bold()
                            .font(.title)
                            .foregroundColor(AppColors.primaryText)
                        
                    case .dailyPage:
                        VStack{
                            Text("Günlük Görevlerim")
                                .bold()
                                .font(.title)
                                .foregroundColor(AppColors.primaryText)
                            
                            Text(mainPageViewModel.updateDate())
                                .font(.subheadline)
                                .foregroundColor(AppColors.secondaryText)
                        }
                    }
                }
            }
    

        
        
    }
        
}

#Preview {
    ToDoListView(mode: .routinePage)
}

