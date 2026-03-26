//
//  CalendarComponent.swift
//  DailyNest
//
//  Created by Atakan on 19.03.2026.
//

import SwiftUI

struct CalendarComponent: View {
    @Environment(CalendarHelper.self) private var calendarHelper

    @Binding var selectedDate: Date
    @Binding var displayedDate: Date
    @Binding var isExpanded: Bool
    let rowHeight: CGFloat

    @State private var pageIndex: Int = 1
    @State private var anchorDate: Date // Takvim Flash dönmesini önleyici.

    var weekDays: [String] {
        let days = Calendar.current.shortWeekdaySymbols
        return days.map { $0.uppercased() }
    }

    init(selectedDate: Binding<Date>, displayedDate: Binding<Date>, isExpanded: Binding<Bool>, rowHeight: CGFloat) {
        _selectedDate = selectedDate
        _displayedDate = displayedDate
        _isExpanded = isExpanded
        self.rowHeight = rowHeight

        _anchorDate = State(initialValue: displayedDate.wrappedValue)
    }

    var body: some View {
        VStack {
            HStack {
                ForEach(weekDays, id: \.self) { day in
                    Text(day)
                        .frame(maxWidth: .infinity)
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.secondary)
                }
            }
            .padding(.horizontal, 8)

            TabView(selection: $pageIndex) {
                gridContent(for: pageDate(-1)).tag(0)
                gridContent(for: pageDate(0)).tag(1)
                gridContent(for: pageDate(1)).tag(2)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: isExpanded ? CGFloat(CGFloat(6)) * rowHeight : rowHeight)
            .clipped()
            .animation(.spring(response: 0.4, dampingFraction: 0.8), value: isExpanded)
            .onChange(of: pageIndex) { _, newValue in
                guard newValue != 1 else { return } // Sonsuz döngü kıruması
                let direction = newValue == 0 ? -1 : 1 // Yön sağa kaydırdı -> Geri git = -1
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { // Takvime zaman tanı.
                    let newDate = pageDate(direction)
                    anchorDate = newDate // anchorDate güncelle
                    displayedDate = newDate // parent'ı bilgilendir

                    pageIndex = 1 // yeni merkez burası.
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
            to: anchorDate
        )!
    }
}
