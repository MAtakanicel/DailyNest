//
//  NavBarDoneButton.swift
//  DailyNest
//
//  Created by Atakan on 27.03.2026.
//

import SwiftUI

struct NavBarDoneButton: View {
    @Binding var mode: DetailSheetMode
    let isValid : Bool
    let isTask: Bool
    let onConfirm: () -> Void
    
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        switch mode {
        case .create:
            Button {
                onConfirm()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                    dismiss()
                }
            } label: {
                Text("Create")
                    .font(.title3)
                    .foregroundColor(isValid ? (isTask ? AppColors.button : AppColors.routine): .gray.opacity(0.35))
            }
            .disabled(!isValid)

        case .detail:
            Button { mode = .edit } label: {
                Text("Edit")
                    .font(.title3)
                    .foregroundColor(AppColors.button)
            }

        case .edit:
            Button {
                onConfirm()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                    mode = .detail
                }
            } label: {
                Text("Done")
                    .font(.title3)
                    .foregroundColor(AppColors.button)
            }
        }
    }
}

