//
//  CalendarHelprs.swift
//  DailyNest
//
//  Created by Atakan on 19.03.2026.
//

import Foundation
import Observation

class CalendarHelper : Observable{
    var calendar = Calendar.current
    
    var weekDays: [Date] {
        guard let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: Date())?.start else { return [] }
        return (0 ..< 7).compactMap {
            calendar.date(byAdding: .day, value: $0, to: startOfWeek)
        }
    }
}
