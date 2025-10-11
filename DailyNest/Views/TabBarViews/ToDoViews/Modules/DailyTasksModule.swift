import SwiftUI

struct DailyTasksModule: View {
    @StateObject private var viewModel = ToDoViewModel()
    var body: some View {
        ScrollView{
            LazyVStack(alignment: .leading, spacing: 12,){
                Section {
                    ForEach(viewModel.mainPageToDos){ todo in
                        ToDoRow(todo: todo, mode : .compact)
                                .padding(.horizontal,3)
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: 500)
        .background(GradientSectionBackground(viewStyle: .mainPage))
        .padding(.bottom,10)
    }
}


#Preview {
    TabBarView()
}
