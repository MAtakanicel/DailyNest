
import SwiftUI

struct ToDoListView: View {
    @StateObject private var toDoViewModel = ToDoViewModel()
    @Binding var path: [ToDo]
    var body: some View {
        VStack(alignment:.leading,spacing: 10){

                Text("Rutimlerim")
                    .bold()
                    .font(.title)
                    .foregroundColor(AppColors.primaryText)
                
                ScrollView{
                    LazyVStack{
                        Section{
                            ForEach(toDoViewModel.todos){ todo in
                                ToDoRow(todo: todo,mode: .detailed,onTap: {path.append(todo)})
                                    .padding(.bottom, 5)
                            }
                        }
                    }
                }
                .padding()
                .background(GradientSectionBackground())
            
            
        }
        .padding()
        .background(AppColors.background)
        .toolbar{
            ToolbarItem(placement: .principal){
                VStack{
                    
                }
            }
        }
        
        
    }
}

#Preview {
    ToDoListView(path: .constant([]))
}
