//
//  DailyDescriptionField.swift
//  DailyNest
//
//  Created by Atakan on 26.03.2026.
//

import SwiftUI

struct DescriptionField: View {
    @Binding var details: String
    var body: some View {
        ZStack(alignment: .topLeading) {
            RoundedRectangle(cornerRadius: 16)
                .fill(.gray.opacity(0.1))
                .stroke(AppColors.overlayStroke.opacity(0.15), lineWidth: 0.5)

            Text("Description (optional)")
                .foregroundColor(AppColors.secondaryText)
                .font(.caption)
                .padding(8)
                .padding(.top, 6)
                .visible(details.isEmpty)

            TextEditor(text: $details)
                .foregroundColor(AppColors.primaryText)
                .font(.caption)
                .padding(4)
                .frame(height: 150)
                .textEditorStyle(.plain)
        }
    }
}
