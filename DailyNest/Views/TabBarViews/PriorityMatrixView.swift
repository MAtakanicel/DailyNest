//
//  SwiftUIView.swift
//  DailyNest
//
//  Created by Atakan on 15.03.2026.
//

import SwiftUI
import SwiftData

enum RoundedCorner{
    case topLeading
    case topTrailing
    case bottomLeading
    case bottomTrailing
    
    
}

struct PriorityMatrixView: View {
    @Environment(RoutineViewModel.self) private var routineViewModel
    @Environment(DailyViewModel.self) private var dailyViewModel
    
    @Query private var dailyTasks : [DailyTask]
    @Query private var routines: [RoutineTask]
    
    
    
    var body: some View {
        ZStack{
            AppColors.background.ignoresSafeArea()
            
            VStack{
                HStack{
                    
                    VStack{
                        
                    }.background(
                        //RoundedCorner.bottomLeading.shape()
                    )
                    
                    VStack{
                        
                    }.clipShape(
                       // RoundedCorner.bottomLeading.shape()
                            )
                }
                
                HStack{
                    UnevenRoundedRectangle(
                        topLeadingRadius: 0,
                        bottomLeadingRadius: 20,
                        bottomTrailingRadius: 0,
                        topTrailingRadius: 0
                    )
                   
                    
                    
                }
            }
            .padding(.horizontal,20)
            .padding(.bottom, 70)
        }
        .navigationTitle("Prioty Matrix")
        .navigationBarTitleDisplayMode(.inline)
    }

    
}



#Preview {
   
    TabBar(selectedTab: .priority)
            .modelContainer(MockData.previewContainer)
            .environment(HomeViewModel())
            .environment(DailyViewModel())
            .environment(RoutineViewModel())
    
}
