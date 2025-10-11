
import SwiftUI

enum Mode{
    case routinePage
    case dailyPage
}

enum ToDoFilter: String, CaseIterable{
    case active = "Aktifler"
    case all = "Tümü"
}

struct ToDoListView: View {
    let mode: Mode
    @StateObject private var toDoViewModel = ToDoViewModel()
    @StateObject private var mainPageViewModel = MainPageViewModel()
    @StateObject private var progressCardViewModel = ProgressCardViewModel()
    @State private var selectFilter : ToDoFilter = .all

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
            switch selectFilter {
            case .active:
                return toDoViewModel.activeRoutineTodos
            case .all:
               return toDoViewModel.routineTodos
            }
        case .dailyPage:
            switch selectFilter {
            case .active:
                return toDoViewModel.activeDailyTodos
            case .all:
                return toDoViewModel.dailyTodos
            }
        }
    }
    
    var title: String{
        switch mode{
        case .dailyPage:
            return " Görevlerim"
        case .routinePage:
            return "Rutinlerim"
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
          
        
      /*      Text(title)
                .font(.title2.bold())
                .foregroundColor(AppColors.primaryText)
                .padding(.leading,10)
                .padding(.bottom,5)

       */
            Text(description)
                .font(.subheadline)
                .foregroundColor(AppColors.secondaryText)
                .padding(.leading,20)
                .padding(.bottom,20)
            
            
            ProgressCard(config: progressConfig)
                .padding(.bottom,15)
            
            Picker("Filtre",selection: $selectFilter){
                ForEach(ToDoFilter.allCases, id: \.self){ filter in
                    Text(filter.rawValue)
                }
            }
            .pickerStyle(.segmented)
            .padding(.bottom,5)
            .padding(.horizontal,40)
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
            .padding(.bottom,50)
            
            
        }
        .padding(20)
        .background(AppColors.background)
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ToDoListView(mode: .routinePage)
}

