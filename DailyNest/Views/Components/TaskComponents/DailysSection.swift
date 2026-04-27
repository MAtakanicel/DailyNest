//
//  DailysSection.swift
//  DailyNest
//
//  Created by Atakan on 13.03.2026.
//

import SwiftData
import SwiftUI

struct DailysSections: View {
    let header: String
    let items: [DailyTask]
    @Binding var isExpanded: Bool
    var onToggle: ((DailyTask) -> Void)? = nil
    @Environment(SheetRouter.self) private var sheetRouter

    var body: some View {
        VStack(spacing: 0) {
            Section(isExpanded: $isExpanded) {
                ForEach(items) { item in
                    DailyRow(
                        task: item,
                        onDetail: { sheetRouter.activeSheet = .taskDetail($0) },
                        onToggle: onToggle
                    )
                    .padding(2)
                }
            } header: {
                HStack(alignment: .firstTextBaseline) {
                    Text(header)

                    Spacer()

                    Text("\(items.count)")
                        .padding(.trailing, 5)
                        .foregroundColor(AppColors.secondaryText.opacity(0.85))
                        .font(.callout)

                    Image(systemName: isExpanded ? "chevron.left" : "chevron.down")
                        .foregroundColor(AppColors.secondaryText.opacity(0.65))
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 5)
                .contentShape(RoundedRectangle(cornerRadius: 8))
                .onTapGesture {
                    withAnimation(.spring(.bouncy)) {
                        isExpanded.toggle()
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(10)
        .background(
            GradientSectionBackground(viewStyle: .mainPage)
                .overlay(RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.gray.opacity(0.25), lineWidth: 1))
        )
    }
}

#Preview {
    TabBar(selectedTab: .mainView)
        .modelContainer(MockData.previewContainer)
        .environment(MockData.previewDailyTaskService)
        .environment(MockData.previewRoutineService)
        .environment(ProgressCalculator())
        .environment(SheetRouter())
        .environment(CalendarHelper())
        .environment(MainPageSettings())
        .environment(MatrixSettings())
        .environment(AppSettings())
}
