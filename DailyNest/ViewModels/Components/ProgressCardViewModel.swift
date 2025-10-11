
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
        let gradient: [Color]
        
        switch type{
        case .allToDo:
            title = "Bugünkü İlerlemem"
            gradient = [.blue.opacity(0.8), .purple.opacity(0.8)]
            
        case .dailyToDo:
            title = "Bugünün Görevleri"
            gradient = [.purple.opacity(0.7),.pink.opacity(0.3)]
            
        case .routineToDo:
            title = "Bugünün Rutinleri"
            gradient = [.blue.opacity(0.7), AppColors.accentBlue.opacity(0.3)]
        }
        
        return ProgressCardConfig(
            title: title,
            progressPercentage: percentString,
            progress: progress,
            progressText: "\(completedCount) / \(totalCount) tamamlandı.",
            progressColor: gradient
        )
    }
   
}


