//
//  PriorityButtonSection.swift
//  DailyNest
//
//  Created by Atakan on 24.03.2026.
//

import SwiftUI

struct PriorityButton: View {
    @Environment(MatrixSettings.self) private var matrixSettings
    
    let priority : TaskPriority
    let isSelected : Bool
    let action : () -> Void
    
    var body: some View {
        Button(action: action){
            Text("\(priority.icon(settings: matrixSettings)) \(priority.title(settings: matrixSettings))")
                .lineLimit(1)
                .foregroundColor(AppColors.primaryText)
                .font(.custom("Lora-Regular", size: 13))
                .padding(.vertical, 10)
                .padding(.horizontal, 8)
                .background(
                    Capsule()
                        .fill(.clear)
                        .stroke(isSelected ? priority.color : .gray.opacity(0.5), lineWidth:2)
                )
                .opacity(isSelected ? 1 : 0.6)
        }
        .buttonStyle(.plain)
        .animation(.easeInOut(duration: 0.15), value: isSelected)
        
    }
}

#Preview {
    PriorityButton(priority: .veryHigh, isSelected: true, action: { })
        .environment(MatrixSettings())
}

