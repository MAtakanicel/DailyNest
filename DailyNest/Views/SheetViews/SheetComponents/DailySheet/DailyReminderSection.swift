//
//  DailyReminderSection.swift
//  DailyNest
//
//  Created by Atakan on 26.03.2026.
//

import SwiftUI

struct DailyReminderSection: View {
    @Binding var task : DailyTask
    
    var body: some View {
        HStack(spacing: 0){
            Text("Reminder:")
                .foregroundColor(AppColors.primaryText)
                .font(Font.headline.bold())
                .padding(.trailing, 10)
            
            Toggle("", isOn: Binding(
                        get: { task.isReminderOn },
                        set: { newValue in
                            withAnimation(.smooth) {
                                task.isReminderOn = newValue
                            }
                        }
                    ))
                .labelsHidden()
        }
        .padding(.bottom, 10)
        
        HStack {
            Spacer()
            DatePicker("",selection: $task.reminderDate)
                .labelsHidden()
                .datePickerStyle(.wheel)
            Spacer()
        }
        .transition(.move(edge: .leading).combined(with: .opacity))
        .visible(task.isReminderOn)

    }
}
