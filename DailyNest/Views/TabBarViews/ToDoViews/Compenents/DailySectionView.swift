import SwiftUI

struct DailySectionView: View {
    let todo: [ToDo]
    @State var showToDos: Bool
  //  @Binding var path : [ToDo]
    @State var path : [ToDo] = []
    var body: some View {
        VStack {
            Section {
                if showToDos {
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(todo.filter{ !$0.isRoutine}) { todo in
                            ToDoRow(todo: todo){
                                path.append(todo)
                            }
                            .padding(.vertical,1)
                        }
                    }
                    .padding(15)
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
                }
            } header: {
                SectionHeader(title: "Bugünkü Görevlerim", isExpanded: $showToDos)
            }
        }
        .background {
            if showToDos {
                GradientSectionBackground()
            } else {
                Color.clear
            }
            
        }
    }
}

#Preview {
    DailySectionView(todo: tempToDos().todos , showToDos: true)
}

