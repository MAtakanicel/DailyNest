import SwiftUI

struct DailyTasksModule: View {
    @StateObject private var viewModel = ToDoViewModel()
    @Binding var path : [ToDo]
    var body: some View {
        ScrollView{
            LazyVStack(alignment: .leading, spacing: 12,){
                Section {
                    ForEach(viewModel.sortedActiveTodos){ todo in
                        ToDoRow(todo: todo, mode : .compact){ path.append(todo) }
                                .padding(.horizontal,3)
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: 500)
        .background(GradientSectionBackground())
        .padding(.bottom,10)
    }
}


#Preview {
    TabBarView()
}
