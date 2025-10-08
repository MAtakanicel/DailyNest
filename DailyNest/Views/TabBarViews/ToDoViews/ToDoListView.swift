import SwiftUI

struct ToDoListView: View {
    let todos = tempToDos().todos

    @State private var showRoutines: Bool = true
    @State private var showToDos: Bool = true
    @Binding var path : [ToDo]
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            ToDoListHeader()
                .padding(.leading,25)
            
            ZStack{
                
                
                
                
                
                
                
                //  .navigationDestination(for: ToDo.self){ todo in ToDoDetailView(todo: todo) }
                
                NewToDoAddButtonView()
                
            }//ZStack
            .background(AppColors.background).ignoresSafeArea()
        }.background(AppColors.background)
    }//Body
}//Struct

#Preview {
    TabBarView()
}
