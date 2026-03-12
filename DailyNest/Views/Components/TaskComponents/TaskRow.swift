//
//  TaskRow.swift
//  DailyNest
//
//  Created by Atakan on 30.01.2026.
//

import SwiftUI

struct TaskRow: View {
    var task: DailyTask // Burası düzeltilecek
    let mode: rowMode
    var body: some View {
        HStack {
            NavigationLink(destination: EmptyView()) {
                Text(task.title)
                    .foregroundColor(AppColors.cardText)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(8)
                    .padding(.leading, 5)
            }
            switch mode {
            case .compact:
                EmptyView()

            case .detailed:
                if task.isCompleted {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(AppColors.checkmarkGreen)
                        .padding(.horizontal)
                }
            }
        }
        .background(task.isCompleted ?
            ComponentBackgrounds(component: .toDoCellCompleted) :
            ComponentBackgrounds(component: .toDoCellNotComplited))
        .cornerRadius(16)
        .shadow(color: .gray.opacity(0.25), radius: 2, x: 0, y: 2)
    }
}

#Preview {}
