import SwiftUI

struct DailySectionView: View {
    let dailys: [ToDo]
    @Binding var showToDos: Bool
    @Binding var path : [ToDo]
    
    var body: some View {
        Section {
            if showToDos {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(dailys) { todo in
                        ToDoRow(todo: todo){
                            path.append(todo)
                        }
                            .padding(.vertical,1)
                    }
                }
                .padding(15)
                .background(GradientSectionBackground())
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
            }
        } header: {
            SectionHeader(title: "İŞLERİM", isExpanded: $showToDos)
        }
    }
}

