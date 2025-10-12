
import SwiftUI

struct ToDoDetailView: View {
    let todo: ToDo = ToDo(id: UUID(), title: "Ödev Teslimi", detail: "Proje PDF’ini yükle", date: .now.addingTimeInterval(86400 * 3), createdAt: .now, updateAt: nil, isRoutine: false, routineDays: nil, isCompleted: false, completedAt: nil, priority: .high)
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
    ToDoDetailView()
}
