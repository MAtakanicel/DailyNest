//
//  CalendarView.swift
//  DailyNest
//
//  Created by Atakan on 19.03.2026.
//

import SwiftUI

struct CalendarComponent: View {
    @Binding var selectedDate: Date
    @Binding var displayedMonth: Date 
    @Binding var isExpanded: Bool
    
    @Environment(CalendarHelper.self) private var calendarHelper
    
    var dayLetter: String {
    let formatter = DateFormatter()
    formatter.dateFormat = "EEEEEE"
    return formatter.string(from: Date()).uppercased()
}
    let rowHeight: CGFloat
    
    @State private var pageIndex = 1
    
    private var weeks: [[Date]] { calendarHelper.weeksInMonth(for: displayedMonth) }
    
 
    
    var body: some View {
        VStack{
        TabView(selection: $pageIndex) {
            gridContent(for: pageDate(-1)).tag(0)
            gridContent(for: pageDate(0)).tag(1)
            gridContent(for: pageDate(1)).tag(2)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(height: isExpanded
               ? CGFloat(CGFloat(6)) * rowHeight
               : rowHeight
        )
        .clipped()
        .animation(.spring(response: 0.4, dampingFraction: 0.8), value: isExpanded)
        .onChange(of: pageIndex) { _, newValue in
            guard newValue != 1 else { return }
            let direction = newValue == 0 ? -1 : 1
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation {
                    displayedMonth = Calendar.current.date(
                        byAdding: isExpanded ? .month : .weekOfYear,
                        value: direction,
                        to: displayedMonth
                    )!
                }
                pageIndex = 1
            }
        }
    }
    }
    
    @ViewBuilder
    func gridContent(for date: Date) -> some View {
        let allWeeks = calendarHelper.weeksInMonth(for: date)

        VStack(spacing: 0) {
            if isExpanded {
                          ForEach(allWeeks, id: \.first) { week in
                              weekRow(week, referenceMonth: date)
                          }
                      } else {
                          // Geçilen date'in ait olduğu haftayı göster
                          let currentWeek = calendarHelper.weekDays(for: date)
                          weekRow(currentWeek, referenceMonth: date)
                      }
        }
    }
    
    func weekRow(_ days: [Date], referenceMonth: Date) -> some View {
        HStack(spacing: 0) {
            ForEach(days, id: \.self) { date in
                DayCell(
                    date: date,
                    isSelected: calendarHelper.isSameDay(date, selectedDate),
                    isToday: calendarHelper.isToday(date),
                    isCurrentMonth: calendarHelper.isCurrentMonth(date, reference: referenceMonth),
                    hasDot: false, // task var mı kontrolü eklenebilir
                    mode: .regular
                )
                .frame(maxWidth: .infinity)
                .frame(height: rowHeight)
                .onTapGesture {
                    withAnimation { selectedDate = date }
                }
            }
        }
        .padding(.horizontal, 4)
    }
    
    private func pageDate(_ offset: Int) -> Date {
        Calendar.current.date(
            byAdding: isExpanded ? .month : .weekOfYear,
            value: offset,
            to: displayedMonth
        )!
    }
}

