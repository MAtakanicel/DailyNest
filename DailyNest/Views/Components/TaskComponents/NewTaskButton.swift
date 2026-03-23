//
//  NewTaskButton.swift
//  DailyNest
//
//  Created by Atakan on 17.02.2026.
//

import SwiftData
import SwiftUI

enum NewTaskMode {
    case daily
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
                        case .daily:
                            Circle()
                                .fill(AppColors.button)
                                .overlay(
                                    Circle()
                                        .stroke(AppColors.overlayStroke.opacity(0.1), lineWidth: 0.5)
                                )

                        case .routine:
                            Circle()
                                .fill(AppColors.routine)
                                .overlay(
                                    Circle()
                                        .stroke(AppColors.overlayStroke.opacity(0.1), lineWidth: 0.5)
                                )
                        }
                    }
                )
        }
    }
}

#Preview {}
