//
//  RoutineSection.swift
//  DailyNest
//
//  Created by Atakan on 13.03.2026.
//

import SwiftUI
import SwiftData

struct RoutineSection: View {
    let items : [RoutineTask]
    let context : ModelContext
    @Binding var isExpanded : Bool 
    var body: some View {
        VStack(spacing: 0){
            Section{
              
                if isExpanded{
                    ForEach(items){ item in
                        RoutineRow(routine: item,context: context)
                            .padding(2)
                    }
                }
            }header: {
                HStack(alignment:.firstTextBaseline){
                    
                        Text("Routines")
                        
                        Spacer()
                        
                        Image(systemName: isExpanded ? "chevron.left" : "chevron.down")
                            .foregroundColor(AppColors.secondaryText.opacity(0.65))
                    
                }
                .padding(.horizontal,10)
                .padding(.bottom,5)
                .contentShape(RoundedRectangle(cornerRadius: 8))
                .onTapGesture {
                    isExpanded.toggle()
                }
            }
        }
        .frame(maxWidth:.infinity)
        .padding(10)
        .background(
            GradientSectionBackground(viewStyle: .mainPage)
                .overlay(RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.gray.opacity(0.25),lineWidth: 1)
                )
        )
    }
}

#Preview {
}
