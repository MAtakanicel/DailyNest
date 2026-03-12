//
//  NewDailySheetView.swift
//  DailyNest
//
//  Created by Atakan on 11.03.2026.
//

import SwiftUI

struct NewDailySheetView: View {
    @ObservedObject var dailyViewModel: DailyViewModel

    init(dailyViewModel: DailyViewModel) {
        self.dailyViewModel = dailyViewModel
    }

    @State private var newTitle: String = "s"
    @State private var newDescription: String? = ""
    @State private var newDate: Date = .init()
    @State private var priority: TaskPriority = .medium
    @State private var reminderIsOn: Bool = false
    @State private var reminderTime: Date? = nil

    var body: some View {
        ZStack {
            AppColors.background.ignoresSafeArea()

            VStack(spacing: 16) {
                HStack(spacing: 0) {
                    Text("New ")
                        .font(.title2)
                        .bold()
                        .foregroundStyle(AppColors.primaryText)

                    Text("Daily Task")
                        .italic()
                        .font(.title3)
                        .foregroundStyle(AppColors.primaryText)

                    Spacer()

                    Button {} label: {
                        Text("Done")
                            .foregroundColor(newTitle.isEmpty ? Color.gray : AppColors.primaryText)
                    }
                    .padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 24)
                            .fill(newTitle.isEmpty ? Color.gray.opacity(0.5) : AppColors.button)
                            .stroke(
                                newTitle.isEmpty ? Color.gray : AppColors.button,
                                lineWidth: 2
                            )
                    )
                    .disabled(newTitle.isEmpty)
                }
                .padding(.horizontal, 30)
            }
        }
    }
}

#Preview {
    NewDailySheetView(dailyViewModel: DailyViewModel())
}
