//
//  TaskRow.swift
//  DailyNest
//
//  Created by Atakan on 30.01.2026.
//

import SwiftUI

enum rowMode{
    case compact
    case detailed
}
enum taskState{
    case active
    case completed
}

struct RoutineRow: View {
    var routine: RoutineTask 
    let mode : rowMode
    var body: some View {
            HStack {
                NavigationLink(destination: EmptyView()) {
                    Text(routine.title)
                        .foregroundColor(AppColors.cardText)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(8)
                }
                switch mode{
                case .compact:
                    Button(action: { },label:{
                        Text("Tamamla")
                            .font(.caption.bold())
                            .foregroundColor(AppColors.primaryText)
                            .padding(6)
                            .padding(.horizontal,2)
                    })
                    .background(ToDoButtonsBackgrounds(todoCategory: .row))
                    .cornerRadius(12)
                    .padding(.trailing,15)
                    
                case .detailed:
                    Image(systemName: routine.isCompletedToday ? "checkmark.circle.fill" : "circle")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(routine.isCompletedToday ? AppColors.checkmarkGreen : AppColors.checkmarkRed)
                        .padding(.horizontal)
                    
                }
            }
            .background(routine.isCompletedToday ?
                        CompanentBackgrounds(component: .toDoCellComplited):
                            CompanentBackgrounds(component: .toDoCellNotComplited)
            )
            .cornerRadius(16)
            .shadow(color: .gray.opacity(0.25), radius: 2, x: 0, y: 2)
    }
}

#Preview {
    
}

