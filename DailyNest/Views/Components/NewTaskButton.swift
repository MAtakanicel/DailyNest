//
//  SwiftUIView.swift
//  DailyNest
//
//  Created by Atakan on 17.02.2026.
//

import SwiftUI
import SwiftData

enum NewTaskMode{
    case main
    case routine
}

struct NewTaskButton<Destination: View>: View {
    let mode : NewTaskMode
    let destination : Destination
    var body: some View {
        
        NavigationLink {
            destination
        }label: {
            Image(systemName: "plus")
                .foregroundColor(AppColors.primaryText)
                .font(.system(size: 25))
                .padding(12)
                .background(
                    Group{
                        switch mode{
                        case .main:
                            LinearGradient(colors: [.purple.opacity(0.2),.mint.opacity(0.15)],
                                           startPoint: .topLeading,
                                           endPoint: .bottomTrailing
                            )
                            .shadow(
                                color: .black.opacity(0.1),
                                radius: 3,
                                x: 0,
                                y: 2
                            )
                            .cornerRadius(50)
                            
                        case .routine:
                            LinearGradient(
                                colors: [.mint.opacity(0.2), .green.opacity(0.25) ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                            .shadow(
                                color: .black.opacity(0.1),
                                radius: 3,
                                x: 0,
                                y: 2
                            )
                            .cornerRadius(50)
                        }
                    }
                )
        }

        
    }
}

#Preview {
    TabBar(homeViewModel: HomeViewModel(),dailyViewModel: DailyViewModel(),routineViewModel: RoutineViewModel())
        .modelContainer(MockData.previewContainer)
}
