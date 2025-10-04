import SwiftUI

struct ToDoListView: View {
     @State var todos = [
        ToDo(title: "SwiftUI", isDone: false, isRoutine: false),
        ToDo(title: "Combine", isDone: false, isRoutine: false),
        ToDo(title: "Rutin1", isDone: false, isRoutine: true),
        ToDo(title: "Rutin2", isDone: true, isRoutine: true),
        ToDo(title: "Rutin3", isDone: true, isRoutine: true),
        ToDo(title: "Rutin4", isDone: false, isRoutine: true)
    ]
    
    var routines: [ToDo] { todos.filter { $0.isRoutine } }
    var dailys: [ToDo] { todos.filter { !$0.isRoutine } }

    @State private var showRoutines: Bool = true
    @State private var showToDos: Bool = true
    @State private var path : [ToDo] = []
    
    var body: some View {
        NavigationStack(path: $path) {
  
            ZStack(alignment: .bottomTrailing) {
                
              

                    List{
                        
                        RoutineSectionView(routines: routines, showRoutines: $showRoutines, path: $path)
                        DailySectionView(dailys: dailys, showToDos: $showToDos, path: $path)
                        
                        
                        // Eski
                        /*
                         Section {
                         // MARK: - Eski
                         if showRoutines {
                         VStack(alignment: .leading, spacing: 8) {
                         ForEach(routines.indices, id: \.self) { index in
                         HStack {
                         Text(routines[index].title)
                         .frame(maxWidth: .infinity, alignment: .leading)
                         .padding(8)
                         .cornerRadius(8)
                         .foregroundColor(AppColors.cardText)
                         
                         Image(systemName: routines[index].isDone ? "checkmark.circle.fill" : "circle")
                         .resizable()
                         .frame(width: 20, height: 20)
                         .foregroundColor(AppColors.buttonTapped)
                         .padding(.horizontal)
                         }
                         .background(AppColors.cardBackGround)
                         .cornerRadius(16)
                         .shadow(color: .gray.opacity(0.25), radius: 4, x: 0, y: 2)
                         }
                         }
                         .padding(10)
                         .background(
                         // 🎨 Gradient arka plan
                         RoundedRectangle(cornerRadius: 20)
                         .fill(
                         LinearGradient(
                         colors: [
                         AppColors.sectionBackgroundStart,
                         AppColors.sectionBackgroundEnd
                         ],
                         startPoint: .topLeading,
                         endPoint: .bottomTrailing
                         )
                         )
                         .shadow(color: .black.opacity(0.15), radius: 6, x: 0, y: 3)
                         )
                         .listRowInsets(EdgeInsets())
                         .listRowBackground(Color.clear)
                         }
                         } header: {
                         HStack {
                         Text("GÜNLÜK RUTİNLER")
                         .font(.headline)
                         .foregroundColor(AppColors.sectionText)
                         Button {
                         withAnimation { showRoutines.toggle() }
                         } label: {
                         Image(systemName: showRoutines ? "chevron.down" : "chevron.right")
                         .foregroundColor(AppColors.buttonTapped)
                         }
                         .buttonStyle(BorderlessButtonStyle())
                         }
                         }
                         
                         Section {
                         if showToDos {
                         VStack(alignment: .leading, spacing: 8) {
                         ForEach(dailys.indices, id: \.self) { index in
                         HStack {
                         Text(dailys[index].title)
                         .frame(maxWidth: .infinity, alignment: .leading)
                         .padding(8)
                         .cornerRadius(8)
                         .foregroundColor(AppColors.cardText)
                         
                         Image(systemName: dailys[index].isDone ? "checkmark.circle.fill" : "circle")
                         .resizable()
                         .frame(width: 20, height: 20)
                         .foregroundColor(AppColors.buttonTapped)
                         .padding(.horizontal)
                         }
                         .background(AppColors.cardBackGround)
                         .cornerRadius(16)
                         .shadow(color: .gray.opacity(0.25), radius: 4, x: 0, y: 2)
                         }
                         }
                         .padding(10)
                         .background(
                         RoundedRectangle(cornerRadius: 20)
                         .fill(
                         LinearGradient(
                         colors: [
                         AppColors.sectionBackgroundStart,
                         AppColors.sectionBackgroundEnd
                         ],
                         startPoint: .topLeading,
                         endPoint: .bottomTrailing
                         )
                         )
                         .shadow(color: .black.opacity(0.15), radius: 6, x: 0, y: 3)
                         )
                         .listRowInsets(EdgeInsets())
                         .listRowBackground(Color.clear)
                         }
                         } header: {
                         HStack {
                         Text("İŞLERİM")
                         .font(.headline)
                         .foregroundColor(AppColors.sectionText)
                         Button {
                         withAnimation { showToDos.toggle() }
                         } label: {
                         Image(systemName: showToDos ? "chevron.down" : "chevron.right")
                         .foregroundColor(AppColors.buttonTapped)
                         }
                         .buttonStyle(BorderlessButtonStyle())
                         }
                         }*/
                    }//List
                    .scrollContentBackground(.hidden)
                    .navigationDestination(for: ToDo.self){ todo in
                        ToDoDetailView(todo: todo)
                    }
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button(action: {
                                // yeni todo ekleme işlemi
                            }) {
                                Image(systemName: "plus")
                                    .font(.title2)
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .clipShape(Circle())
                                    .shadow(radius: 5)
                            }
                            .padding()
                        }
                    }
            }

                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(AppColors.background)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {}) {
                            Text("Ekle")
                                .font(.headline)
                                .bold()
                                .foregroundColor(AppColors.button)
                        }
                    }
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
                }
        }
    }
}

#Preview {
    TabBarView()
}
