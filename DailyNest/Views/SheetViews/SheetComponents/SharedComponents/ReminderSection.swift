//
//  DailyReminderSection.swift
//  DailyNest
//
//  Created by Atakan on 26.03.2026.
//

import SwiftUI

struct ReminderSection: View {
    @Binding var isReminderOn: Bool
    @Binding var reminderDate: Date
    
    var body: some View {
        HStack(spacing: 0) {
            Text("Reminder:")
                .foregroundColor(AppColors.primaryText)
                .font(Font.headline.bold())
                .padding(.trailing, 10)

            Toggle("", isOn: Binding(
                get: { isReminderOn },
                set: { newValue in
                    withAnimation(.smooth) {
                        isReminderOn = newValue
                    }
                }
            ))
            .labelsHidden()
        }
        .padding(.bottom, 10)

        HStack {
            Spacer()
            DatePicker("", selection: $reminderDate, in: Date.now...)
                .labelsHidden()
                .datePickerStyle(.wheel)
            Spacer()
        }
        .transition(.move(edge: .leading).combined(with: .opacity))
        .visible(isReminderOn)
    }
}
