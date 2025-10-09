import SwiftUI

enum ToDoRowMode{
    case compact
    case detailed
}

struct ToDoRow: View {
    var todo: ToDo
    let mode : ToDoRowMode
    let onTap: (() -> Void)?


    var body: some View {
            HStack {
                Text(todo.title)
                    .foregroundColor(AppColors.cardText)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(8)
                    .onTapGesture {
                        onTap?()
                    }
                
                
                switch mode{
                case .compact: Button(action: { },label:{
                    Text("Tamamla")
                        .font(.caption.bold())
                        .foregroundColor(AppColors.primaryText)
                        .padding(6)
                })
                .background(LinearGradient(colors: [AppColors.accentBlue.opacity(0.2), .purple.opacity(0.1)], startPoint: .topLeading, endPoint: .bottomTrailing))
                .cornerRadius(12)
                .padding(.trailing,15)
                    
                case .detailed:
                    if !todo.isDone{
                        
                    
                    }else{
                        Image(systemName: todo.isDone ? "checkmark.circle.fill" : "circle")
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


    }
}

#Preview {
    TabBarView()
}

