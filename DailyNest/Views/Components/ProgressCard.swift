//
//  ProgressCard.swift
//  DailyNest
//
//  Created by Atakan on 30.01.2026.
//

import SwiftUI
enum ProgressDataType {
    case allTasks
    case routineTasks
    case dailyTasks
}

struct ProgressCardConfig{
    let title: String
    let progressPercentage: String
    let progress: CGFloat
    let progressText: String
    let progressColor: [Color]
}

struct ProgressCard: View {
    let config : ProgressCardConfig
    var body: some View {
            HStack{
                    ZStack{
                        Circle()
                            .stroke(lineWidth: 8)
                            .foregroundColor(.white)
                        
                        Circle()
                            .trim(from: 0, to: config.progress)
                            .stroke(
                                AngularGradient(
                                    colors: config.progressColor ,
                                    center: .top),
                                style: StrokeStyle(lineWidth: 8, lineCap: .round)
                            )
                            .rotationEffect(.degrees(-90))
                        
                        Text(config.progressPercentage)
                            .font(.headline)
                            .bold()
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
            .background(ComponentBackgrounds(component: .progressCard))
    }
}


#Preview{
   
}
