//
//  DatePickerSheet.swift
//  DailyNest
//
//  Created by Atakan on 19.03.2026.
//

import SwiftUI

struct DatePickerSheet: View {
    @Binding var timeFilterStartDate: Date
    @Binding var timeFilterEndDate: Date
    @Binding var setDate: MatrixTimeFilter
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        ZStack {
            AppColors.background.ignoresSafeArea()
            VStack {
                Spacer()

                Text("Time Filter")
                    .font(.title.bold())
                    .foregroundColor(AppColors.primaryText)

                Spacer()

                VStack(spacing: 25) {
                    DatePicker(
                        "Start Time",
                        selection: $timeFilterStartDate,
                        in: ...Date(),
                        displayedComponents: .date
                    )
                    .datePickerStyle(.compact)
                    .id(timeFilterStartDate)

                    DatePicker(
                        "End Time",
                        selection: $timeFilterEndDate,
                        in: timeFilterStartDate...,
                        displayedComponents: .date
                    )
                    .datePickerStyle(.compact)
                    .id(timeFilterEndDate)
                }
                .padding(.horizontal, 30)

                Spacer()

                Button {
                    setDate = .custom
                    dismiss()
                } label: {
                    Text("Done")
                        .foregroundColor(AppColors.primaryText).bold()
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                }
                .background(
                    Capsule()
                        .fill(AppColors.daily)
                )
                .padding(.top, 15)
            }
        }
    }
}
