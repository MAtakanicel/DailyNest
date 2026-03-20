//
//  AgendaView.swift
//  DailyNest
//
//  Created by Atakan on 30.01.2026.
//

import SwiftData
import SwiftUI

struct AgendaView: View {
    @Environment(CalendarHelper.self) private var calendarHelper
    @Environment(DailyViewModel.self) private var dailyViewModel
    @Environment(SheetRouter.self) private var sheetRouter
    @Environment(\.modelContext) private var context
    
    @Query(sort: \DailyTask.date, order: .reverse) private var dailyTasks : [DailyTask]
    
        @State private var selectedDate = Date()
        @State private var displayedMonth = Date()
        @State private var isExpanded = false
        @State private var dragOffset: CGFloat = 0
        
        private let dayNames = ["Paz", "Pzt", "Sal", "Çar", "Per", "Cum", "Cmt"]
        private let rowHeight: CGFloat = 40
        
        // Kaç satır gösterilecek
        private var visibleRowCount: Int {
            isExpanded ? calendarHelper.weeksInMonth(for: displayedMonth).count : 1
        }
        
    var weekDays : [String] {
        let days = Calendar.current.shortWeekdaySymbols
        return days.map{ $0.uppercased() }
    }

        
    var body: some View {
        ZStack {
            AppColors.background.ignoresSafeArea()
            VStack(spacing: 0) {
                // MARK: - Gün başlıkları
              HStack {
                    ForEach(weekDays, id: \.self) { day in
                        Text(day)
                            .frame(maxWidth: .infinity)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.horizontal, 8)
                .padding(.bottom,5)
                
                // MARK: - Takvim Grid
                CalendarComponent(
                    selectedDate: $selectedDate,
                    displayedMonth: $displayedMonth,
                    isExpanded: $isExpanded,
                    rowHeight: rowHeight
                )
                Divider()
            
                Spacer()
                
            }
            .gesture(
                DragGesture()
                    .onChanged { value in
                        dragOffset = value.translation.height
                    }
                    .onEnded { value in
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                            if value.translation.height > 30 {
                                isExpanded = true
                            } else if value.translation.height < -30 {
                                isExpanded = false
                            }
                        }
                        dragOffset = 0
                    }
            )
            .onChange(of: selectedDate) { _, newDate in
                displayedMonth = newDate
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .principal) {
                VStack(spacing: 2) {
                    Text(calendarHelper.monthTitle(for: displayedMonth))
                        .font(.title2).bold()
                    if !isExpanded {
                        Text("Bugün")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }

            }
        }
    }
}

#Preview {
    TabBar(selectedTab: .agendaView)
        .modelContainer(MockData.previewContainer)
        .environment(HomeViewModel())
        .environment(DailyViewModel())
        .environment(RoutineViewModel())
        .environment(SheetRouter())
        .environment(CalendarHelper())
}
