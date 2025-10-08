import SwiftUI

struct DailyTasksModule: View {
    @StateObject private var viewModel = ToDoViewModel()
   @Binding var path : [ToDo]
    var body: some View {
        ScrollView{
            LazyVStack(alignment: .leading, spacing: 12,){
                Section {
                    ForEach(viewModel.sortedTodos){ todo in
                        
                        ToDoRow(todo: todo){ path.append(todo) }
                        
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: 500)
        .background(GradientSectionBackground())
    }
}


#Preview {
    TabBarView()
}
