
import Foundation
import SwiftUI

@MainActor
final class ProgressCardViewModel : ObservableObject{
    @Published var todos: [ToDo] = MockData.mockData
    
    func config(for type: ProgressDataType) -> ProgressCardConfig {
        
        let filtred: [ToDo]
        switch type{
            case .allToDo:
                filtred = todos
            
            case.dailyToDo:
            filtred = todos.filter { !$0.isRoutine }
            
            case .routineToDo:
            filtred = todos.filter { $0.isRoutine }
        }
        
        let completedCount = filtred.filter { $0.isCompleted }.count
        let totalCount = filtred.count
        let progress = totalCount > 0 ? CGFloat(completedCount) / CGFloat(totalCount) : 0
        let percentString = "\(Int(progress * 100))%"
        
        let title: String
        let color: [Color]
        
        switch type{
        case .allToDo:
            title = "Bugünkü İlerlemem"
            color = [AppColors.progressBlue]
            
        case .dailyToDo:
            title = "Bugünün Görevleri"
            color = [AppColors.progressPurple]
            
        case .routineToDo:
            title = "Bugünün Rutinleri"
            color = [AppColors.progressGreen]
        }
        
        return ProgressCardConfig(
            title: title,
            progressPercentage: percentString,
            progress: progress,
            progressText: "\(completedCount) / \(totalCount) tamamlandı.",
            progressColor: color
        )
    }
   
}


struct ProgressCard_Previewss: PreviewProvider {
    static var vm = ProgressCardViewModel()
    static var previews: some View {
        VStack(spacing: 30){
            ProgressCard(config: vm.config(for: .allToDo))
            ProgressCard(config: vm.config(for: .dailyToDo))
            ProgressCard(config: vm.config(for: .routineToDo))
        }.padding(20)
            .background(AppColors.background)
    }
}
