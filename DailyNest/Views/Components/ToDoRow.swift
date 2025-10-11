import SwiftUI

enum ToDoRowMode{
    case compact
    case detailed
}

struct ToDoRow: View {
    var todo: ToDo
    let mode : ToDoRowMode
    var body: some View {
            HStack {
                NavigationLink(destination: ToDoDetailView(todo: todo)) {
                    Text(todo.title)
                        .foregroundColor(AppColors.cardText)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(8)
                }
   
                
                switch mode{
                case .compact: Button(action: { },label:{
                    Text("Tamamla")
                        .font(.caption.bold())
                        .foregroundColor(AppColors.primaryText)
                        .padding(6)
                        .padding(.horizontal,2)
                })
                .background(ToDoButtonsBackgrounds(todoCategory: .row))
                .cornerRadius(12)
                .padding(.trailing,15)
                    
                case .detailed:
                    if !todo.isCompleted{
                        
                    
                    }else{
                        Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(AppColors.buttonTapped)
                            .padding(.horizontal)
                     
                    }
                }
            }
            .background(AppColors.cardBackGround)
            .cornerRadius(16)
            .shadow(color: .gray.opacity(0.25), radius: 2, x: 0, y: 2)
            .navigationDestination(for: ToDo.self){ todo in ToDoDetailView(todo: todo) }


    }
}

#Preview {
    TabBarView()
}

