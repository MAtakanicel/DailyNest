
import SwiftUI

enum Mode{
    case routinePage
    case dailyPage
}

struct ToDoListView: View {
    let mode: Mode
    @StateObject private var toDoViewModel = ToDoViewModel()
    @StateObject private var mainPageViewModel = MainPageViewModel()
    @StateObject private var progressCardViewModel = ProgressCardViewModel()
    @State private var showCompleted: Bool = false

    var progressConfig : ProgressCardConfig{
        switch mode{
        case .routinePage:
            return progressCardViewModel.config(for: .routineToDo)
            
        case . dailyPage:
            return progressCardViewModel.config(for: .dailyToDo)
        }
    }
    
    var todos: [ToDo] {
        switch mode {
        case .routinePage:
            if showCompleted{
                return toDoViewModel.routineTodos
            }else{
                return toDoViewModel.activeRoutineTodos
            }
        case .dailyPage:
            if showCompleted{
                return toDoViewModel.dailyTodos
            }else{
                return toDoViewModel.activeDailyTodos
            }
        }
    }
    
    var title: String{
        switch mode{
        case .dailyPage:
            return "Bugünün görevleri"
        case .routinePage:
            return "Bugünün rutinleri"
        }
    }
    
    var description: String{
        switch mode{
        case .dailyPage:
            return "Bu güne ait tüm görevleriniz."
        case .routinePage:
            return "Bu güne ait tüm rutinleriniz."
        }
    }
    
    var background: GradientSectionBackground{
        switch mode {
        case .routinePage:
            return GradientSectionBackground(viewStyle: .routinePage)
        case .dailyPage:
            return GradientSectionBackground(viewStyle: .dailyPage)
        }
    }
    
    
    var body: some View {
        VStack(alignment:.leading,spacing: 0){
          
        
            Text(title)
                .font(.title2.bold())
                .foregroundColor(AppColors.primaryText)
                .padding(.leading,10)
                .padding(.bottom,5)
                .padding(.top,15)
            
            Text(description)
                .font(.subheadline)
                .foregroundColor(AppColors.secondaryText)
                .padding(.leading,20)
                .padding(.bottom,20)
            
            
            ProgressCard(config: progressConfig)
                .padding(.bottom,15)
            
            
            
            ScrollView{
                LazyVStack{
                    Section{
                        ForEach(todos){ todo in
                            ToDoRow(todo: todo,mode: .detailed)
                                .padding(.bottom, 5)
                        }
                    }
                }
            }
            .padding()
            .background(background)
            
            
            
        }
        .padding(20)
        .background(AppColors.background)
    }
}

#Preview {
    ToDoListView(mode: .dailyPage)
}

