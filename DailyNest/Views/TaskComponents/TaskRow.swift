//
//  TaskRow.swift
//  DailyNest
//
//  Created by Atakan on 30.01.2026.
//

import SwiftUI

struct TaskRow: View {
    var task: DailyTask //Burası düzeltilecek
    let mode : rowMode
    var body: some View {
            HStack {
                NavigationLink(destination: EmptyView()) {
                    Text(task.title)
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
                    Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(task.isCompleted ? AppColors.checkmarkGreen : AppColors.checkmarkRed)
                        .padding(.horizontal)
                    
                }
            }
            .background(task.isCompleted ?
                        CompanentBackgrounds(component: .toDoCellComplited):
                            CompanentBackgrounds(component: .toDoCellNotComplited)
            )
            .cornerRadius(16)
            .shadow(color: .gray.opacity(0.25), radius: 2, x: 0, y: 2)
    }
}

#Preview {
    
}

