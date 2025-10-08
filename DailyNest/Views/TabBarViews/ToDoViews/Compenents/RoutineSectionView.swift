import SwiftUI

struct RoutineSectionView: View {
    let todo: [ToDo]
    @Binding var showRoutines: Bool
    @Binding var path : [ToDo]

    var body: some View {
        VStack {
            Section {
                if showRoutines {
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(todo.filter { $0.isRoutine }) { todo in
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
                SectionHeader(title: "GÜNLÜK RUTİNLER")
            }
        }
        .background {
            if showRoutines {
                GradientSectionBackground()
            } else {
                Color.clear
            }
        }
    }
}

#Preview {
    TabBarView()
}

