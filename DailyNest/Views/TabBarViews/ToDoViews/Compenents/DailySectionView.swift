import SwiftUI

struct DailySectionView: View {
    let todo: [ToDo]
  //  @Binding var path : [ToDo]
    @State var path : [ToDo] = []
    var body: some View {
        VStack(alignment: .center) {
            Section {
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(todo.filter{ !$0.isRoutine}) { todo in
                            ToDoRow(todo: todo){
                                path.append(todo)
                            }
                            .padding(.vertical,1)
                        }
                    }
                    .padding(.horizontal,15)
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
            } header: {
                SectionHeader(title: "Bugünkü Görevlerim")

                    
            }
        }
        .background(GradientSectionBackground())

            
        
    }
}

#Preview {
    DailySectionView(todo: tempToDos().todos)
}

