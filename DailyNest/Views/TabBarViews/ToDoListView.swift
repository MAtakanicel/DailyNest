
import SwiftUI

struct ToDoListView: View {
    let todos = [
        ToDo(title: "SwiftUI", isDone: false),
        ToDo(title: "Combine", isDone: true)
        
    ]
    
    let routines = [
        RoutineToDo(title: "Yemeği",isDone: false),
        RoutineToDo(title: "Kızımı",isDone: true),
    ]
    
    @State private var showRoutines : Bool = true
    @State private var showToDos : Bool = true
    var body: some View {
        NavigationStack{
            VStack{
                List{
                    //Rutinler
                    Section{
                        if showRoutines{
                            VStack(alignment: .leading,spacing: 8){
                                ForEach(routines) { routine in
                                    HStack{
                                    Text(routine.title)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(8)
                                        .cornerRadius(8)
                                        
                                     
                                    }
                                }
                            }.padding(.vertical,4)
                        }
                    }header: {
                        HStack{
                            Text("Günlük Rutinler")
                                .font(.headline)
                         
                            Button {
                                withAnimation { showRoutines.toggle() }
                            } label: {
                                Image(systemName: showRoutines ? "chevron.down" : "chevron.right")
                                    .foregroundColor(AppColors.buttonTapped)
                            }.buttonStyle(BorderlessButtonStyle())
                        }
                    }
                }
            }.padding(.top,-20)
                    .frame(maxWidth: .infinity,maxHeight: .infinity)
                    .background(AppColors.background)
                    .toolbar{
                        ToolbarItem(placement: .topBarTrailing, content: {
                            Button(action: { }){
                                Text("Ekle")
                                    .font(.headline)
                                    .bold()
                                    .foregroundColor(AppColors.button)
                            }
                        })
                        ToolbarItem(placement: .principal, content: {
                            VStack{
                                Text("Bugünüm").font(.headline).foregroundColor(AppColors.primaryText)
                                Text(Date(),style: .date).font(.subheadline).foregroundColor(AppColors.secondaryText)
                            }
                        })
                    }
            }
        }
    }


#Preview {
    ToDoListView()
}
