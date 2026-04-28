//
//  NavBarTitle.swift
//  DailyNest
//
//  Created by Atakan on 27.03.2026.
//

import SwiftUI

struct NavBarTitle: View {
    let mode : DetailSheetMode
    let isDaily : Bool
    let title: String
    
    var body: some View {
        switch mode {
        case .create:
            HStack(spacing: 0) {
                Text("New")
                    .foregroundColor(AppColors.primaryText)
                    .font(.title2.bold())
                    .padding(.trailing, 3)

                Text(isDaily ? "Daily Task" : "Routine")
                    .foregroundStyle(AppColors.secondaryText)
                    .italic()
                    .padding(.top, 2)
            }

        case .detail:
            Text(title)
                .font(.title3.italic())
                .foregroundColor(AppColors.primaryText)
                .lineLimit(1)

        case .edit:
            VStack(spacing: 0) {
                Text(title)
                    .font(.title3.italic())
                    .foregroundColor(AppColors.primaryText)
                    .lineLimit(1)

                Text("Editing")
                    .font(.caption)
                    .foregroundColor(AppColors.secondaryText)
            }
        }
    }
}

