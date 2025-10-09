
import SwiftUI

struct ToDoListView: View {
    @StateObject private var todoVM = ToDoViewModel()
    @Binding var path: [ToDo]
    var body: some View {
        VStack(spacing: 10){
            GreetingsModule()
                .padding(.leading,25)
                .padding(.top, 10)
                .padding(.bottom,20)
            
            VStack{
                Text("Rutimlerim")
                    .bold()
                    .font(.title)
                    .foregroundColor(AppColors.primaryText)
                
                ScrollView{
                    LazyVStack{
                        Section{
                            ForEach(todoVM.todos){ todo in
                                ToDoRow(todo: todo,mode: .detailed,onTap: {path.append(todo)})
                            }
                        }
                    }
                }
            }
            
        }
        .background(AppColors.background)
        
        
        
    }
}

#Preview {
    ToDoListView(path: .constant([]))
}
