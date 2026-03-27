//
//  DailyTitleField.swift
//  DailyNest
//
//  Created by Atakan on 26.03.2026.
//

import SwiftUI

struct TitleField: View {
    @Binding var title: String
    var body: some View {
        TextField("Task title", text: $title)
            .foregroundColor(AppColors.primaryText)
            .lineLimit(1)
            .padding(10)
            .background(
                Capsule()
                    .fill(.gray.opacity(0.1))
                    .stroke(AppColors.overlayStroke.opacity(0.15), lineWidth: 0.5)
            )
    }
}
