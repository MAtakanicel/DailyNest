//
//  RoutineDailyLog.swift
//  DailyNest
//
//  Created by Atakan on 26.04.2026.
//

import Foundation
import SwiftData

@Model
final class RoutineDailyLog {
    var date: Date
    var todaysCompletionCount: Int

    init(date: Date, todaysCompletionCount: Int = 0) {
        self.date = date
        self.todaysCompletionCount = todaysCompletionCount
    }
}
