//
//  PriorityButtonSection.swift
//  DailyNest
//
//  Created by Atakan on 24.03.2026.
//

import SwiftUI

struct PrioritySection: View {
    @Environment(MatrixSettings.self) private var matrixSettings
    @Binding var selected: TaskPriority

    var body: some View {
        HStack {
            Text("Priority:")
                .font(.headline.bold())
                .foregroundColor(AppColors.primaryText)
            
            Picker("", selection: $selected){
                ForEach(TaskPriority.allCases, id: \.self){ buttonPriority in
                    priorityButton(priority: buttonPriority,isSelected: selected == buttonPriority){
                        selected = buttonPriority
                    }
                    .padding(5)
                }
            }
            .tint(AppColors.primaryText)
            .padding(.vertical, 4)
            .padding(.horizontal, 6)
            .background(
                Capsule()
                    .fill(.clear)
                    .stroke( selected.color, lineWidth:2)
            )
            
            Spacer()
        }
    }
    
    private func priorityButton(priority: TaskPriority, isSelected: Bool, action: @escaping () -> Void) ->  some View {
        Button(action: action){
            Text("\(priority.icon(settings: matrixSettings)) \(priority.title(settings: matrixSettings))")
                .lineLimit(1)
                .foregroundColor(AppColors.primaryText)
                .font(.custom("Lora-Regular", size: 13))
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    NavigationStack {
        DailySheetView(dailyTask: DailyTask(
            title: "Buy groceries",
            details: "Milk, eggs, bread",
            date: .now,
            priority: .medium
        ))
            .environment(DailyViewModel())
            .environment(SheetRouter())
            .environment(MatrixSettings())
    }
}

