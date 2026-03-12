//
//  NewTaskButton.swift
//  DailyNest
//
//  Created by Atakan on 17.02.2026.
//

import SwiftData
import SwiftUI

enum NewTaskMode {
    case main
    case routine
}

struct NewTaskButton: View {
    let mode: NewTaskMode
    let onTap: () -> Void
    var body: some View {
        Button {
            onTap()
        } label: {
            Image(systemName: "plus")
                .foregroundColor(AppColors.primaryText)
                .font(.system(size: 25))
                .padding(12)
                .background(
                    Group {
                        switch mode {
                        case .main:
                            ToDoButtonsBackgrounds(todoCategory: .daily)
                                .shadow(
                                    color: .black.opacity(0.1),
                                    radius: 3,
                                    x: 0,
                                    y: 2
                                )
                                .cornerRadius(50)

                        case .routine:
                            ToDoButtonsBackgrounds(todoCategory: .routine)
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
    TabBar()
        .modelContainer(MockData.previewContainer)
}
