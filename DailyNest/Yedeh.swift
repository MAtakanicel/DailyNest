import SwiftUI

struct ToDoListYedek: View {
     @State var todos = [
        ToDo(title: "SwiftUI", isDone: false, isRoutine: false),
        ToDo(title: "Combine", isDone: true, isRoutine: false),
        ToDo(title: "Rutin1", isDone: false, isRoutine: true),
        ToDo(title: "Rutin2", isDone: false, isRoutine: true),
        ToDo(title: "Rutin3", isDone: false, isRoutine: true),
        ToDo(title: "Rutin4", isDone: false, isRoutine: true),
        ToDo(title: "SwiftUI", isDone: false, isRoutine: false),
        ToDo(title: "Combine", isDone: true, isRoutine: false),
        ToDo(title: "Rutin1", isDone: false, isRoutine: true),
        ToDo(title: "Rutin2", isDone: false, isRoutine: true),
        ToDo(title: "Rutin3", isDone: false, isRoutine: true),
        ToDo(title: "Rutin4", isDone: false, isRoutine: true),
        ToDo(title: "SwiftUI", isDone: false, isRoutine: false),
        ToDo(title: "Combine", isDone: true, isRoutine: false),
        ToDo(title: "Rutin1", isDone: false, isRoutine: true),
        ToDo(title: "Rutin2", isDone: false, isRoutine: true),
        ToDo(title: "Rutin3", isDone: false, isRoutine: true),
        ToDo(title: "Rutin4", isDone: false, isRoutine: true)
    ]

    @State private var showRoutines: Bool = true
    @State private var showToDos: Bool = true
    @State private var path : [ToDo] = [ ] //yedek özel orjinalde @binding ve tabview'dan alıyor.
    
    var body: some View {
        
            ZStack{
                VStack{
                    ScrollView{
                 //       RoutineSectionView(todo: todos, showRoutines: $showRoutines, path: $path)
                    }
                    
                    ScrollView{
               //         DailySectionView(todo: todos, showToDos: $showToDos, path: $path)
                    }
                    
                    Color.clear.frame(height: 70)
                }
                
                /*
                    List{
                        RoutineSectionView(todo: todos, showRoutines: $showRoutines, path: $path)
                        DailySectionView(todo: todos, showToDos: $showToDos, path: $path)
                        

                    }//List
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                 */
                    .navigationDestination(for: ToDo.self){ todo in ToDoDetailView(todo: todo) }

                    
                //Yeni ToDo
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button{
                                
                            }label: {
                                Image(systemName: "plus")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .font(.title2)
                                    .padding(20)
                                    .background(Circle()
                                        .fill(
                                        LinearGradient(
                                            colors: [.blue, .purple],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing)
                                        )
                                    )
                                    .shadow(color: .blue.opacity(0.4), radius: 10, x: 0, y:4)
                                    .foregroundColor(.white)
                            }
                            .padding(.trailing,20)
                            .padding(.bottom,90)
                            .alignmentGuide(.bottom){ _ in 0}
                        }//HStack
                    }//VStack
            }//ZStack

            .background(AppColors.background)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing){
                    Button{ }label:{
                            Text("deneme")
                    }
                }
                
                //NavigationTitle
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Bugünüm")
                            .font(.headline)
                            .foregroundColor(AppColors.primaryText)
                        
                        Text(Date(), style: .date)
                            .font(.subheadline)
                            .foregroundColor(AppColors.secondaryText)
                    }
                    
                }
            }//toolbar
        //NavigationStack
    }//Body
}//Struct

#Preview {
    ToDoListYedek()
}
