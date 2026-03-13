//
//  DailysSections.swift
//  DailyNest
//
//  Created by Atakan on 13.03.2026.
//

import SwiftUI

struct DailysSections: View {
    let header : String
    let items : [DailyTask]
    @Binding var isExpanded : Bool 
    var body: some View {
        VStack(spacing: 0){
            Section{
              
                if isExpanded{
                    ForEach(items){ item in
                        DailyRow(task: item)
                            .padding(2)
                    }
                }
            }header: {
                HStack(alignment:.firstTextBaseline){
                    
                        Text(header)
                        
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
        .background(GradientSectionBackground(viewStyle: .mainPage) )
    }
}

#Preview {
    
}
