//
//  RoutineRow.swift
//  DailyNest
//
//  Created by Atakan on 30.01.2026.
//

import SwiftUI

enum rowMode {
    case compact
    case detailed
}

enum taskState {
    case active
    case completed
}

struct RoutineRow: View {
    var routine: RoutineTask
    let mode: rowMode
    var body: some View {
        HStack {
            NavigationLink(destination: EmptyView()) {
                Text(routine.title)
                    .foregroundColor(AppColors.cardText)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(8)
                    .padding(.leading, 5)
            }
            switch mode {
            case .compact:
                EmptyView()

            case .detailed:
                if routine.isCompletedToday {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(AppColors.checkmarkGreen)
                        .padding(.horizontal)
                }
            }
        }
        .background(routine.isCompletedToday ?
            ComponentBackgrounds(component: .toDoCellCompleted) :
            ComponentBackgrounds(component: .toDoCellNotComplited))
        .cornerRadius(16)
        .shadow(color: .gray.opacity(0.25), radius: 2, x: 0, y: 2)
    }
}

#Preview {}
