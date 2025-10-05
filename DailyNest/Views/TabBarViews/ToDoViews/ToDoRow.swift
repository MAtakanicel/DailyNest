import SwiftUI

struct ToDoRow: View {
    var todo: ToDo
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
                
                Image(systemName: todo.isDone ? "checkmark.circle.fill" : "circle")
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

#Preview {
    TabBarView()
}

