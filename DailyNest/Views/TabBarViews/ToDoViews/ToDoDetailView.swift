
import SwiftUI

struct ToDoDetailView: View {
    let todo: ToDo
    var body: some View {
        VStack(spacing: 16) {
            Text(todo.title)
                .font(.title2)
                .bold()
                .foregroundColor(AppColors.primaryText)
            
            Text(todo.isRoutine ? "Bu bir günlük rutin." : "Bu bir özel görev.")
                .font(.subheadline)
                .foregroundColor(AppColors.secondaryText)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Görev Detayı")
        .background(AppColors.background.ignoresSafeArea())
    }
}

#Preview {
    ToDoDetailView(todo: ToDo(title: "Deneme", isCompleted: true, isRoutine: false))
}
