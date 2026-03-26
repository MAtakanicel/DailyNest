//
//  DailyDateSection.swift
//  DailyNest
//
//  Created by Atakan on 26.03.2026.
//

import SwiftUI

struct DailyDateSection: View {
    @Binding var task: DailyTask
    var body: some View {
        HStack(spacing: 0) {
            Text("Date: ")
                .font(.headline.bold())
                .foregroundColor(AppColors.primaryText)
                .padding(.trailing, 5)

            DatePicker("", selection: $task.date, displayedComponents: .date)
                .datePickerStyle(.compact)
                .labelsHidden()
        }
    }
}
