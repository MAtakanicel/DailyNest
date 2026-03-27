//
//  NavBarBackButton.swift
//  DailyNest
//
//  Created by Atakan on 27.03.2026.
//

import SwiftUI

struct NavBarBackButton: View {
    @Binding var mode: DetailSheetMode
    @Binding var isAlertShown: Bool
    
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        switch mode {
        case .create:
            Button { dismiss() } label: {
                Text("Cancel")
                    .foregroundColor(.red.opacity(0.9))
                    .font(.title3)
            }
        case .detail:
            Button { isAlertShown.toggle() } label: {
                Image(systemName: "trash")
                    .foregroundColor(.red.opacity(0.9))
                    .font(.title3)
                    .bold()
            }
        case .edit:
            Button { mode = .detail } label: {
                Text("Back")
                    .font(.title3)
                    .foregroundColor(AppColors.primaryText)
            }
        }
    }
}

