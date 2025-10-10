
import SwiftUI

enum ProgressDataType {
    case allToDo
    case routineToDo
    case dailyToDo
}

struct ProgressCardConfig{
    let title: String
    let progressPercentage: String
    let progress: CGFloat
    let progressText: String
    let progressColor: [Color]
}

extension ProgressCardConfig{
    static func forType(_ type: ProgressDataType) -> ProgressCardConfig{
        switch type {
        case .allToDo:
            return ProgressCardConfig(
                title: "Bugünkü İlerlemem",
                progressPercentage: "56%",
                progress: 0.56,
                progressText: "2 todo tamamlandı",
                progressColor: [AppColors.accentBlue, .white])
     
        case .dailyToDo:
            return ProgressCardConfig(
                title: "Bugünün Görevleri" ,
                progressPercentage: "32",
                progress: 0.32,
                progressText: "...",
                progressColor: [.purple.opacity(0.8),.pink.opacity(0.2)])
            
        case .routineToDo:
            return ProgressCardConfig(
                title: "Bugünün Routin İlerlemesi",
                progressPercentage: "70%",
                progress: 0.70,
                progressText: "...",
                progressColor: [.blue.opacity(0.8), AppColors.accentBlue.opacity(0.2)])
            
        }
    }
}

struct ProgressCard: View {
    let config : ProgressCardConfig
    @StateObject var progressViewModel = ProgressViewModel()
    var body: some View {
            HStack{
                    ZStack{
                        Circle()
                            .stroke(lineWidth: 8)
                            .foregroundColor(AppColors.accentBlue)
                        
                        Circle()
                            .trim(from: 0, to: config.progress)
                            .stroke(
                                LinearGradient(
                                    colors: config.progressColor ,
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing),
                                style: StrokeStyle(lineWidth: 8, lineCap: .round)
                            )
                            .rotationEffect(.degrees(-90))
                        
                        Text(config.progressPercentage)
                            .font(.headline)
                    }
                    .frame(width: 70,height: 70)
                    .padding(.trailing, 10)
                    
                    VStack(alignment: .leading, spacing: 4){
                        Text(config.title)
                            .font(.headline)
                            .foregroundColor(AppColors.primaryText)
                        
                        Text(config.progressText)
                            .foregroundColor(AppColors.secondaryText)
                            .font(.subheadline)
                    }
               
                Spacer()
            }
            .padding(25)
            .background(CompanontBackgrounds(component: .progressCard))
    }
}

#Preview {
    TabBarView()
}
