//
//  SharedModels.swift
//  DailyNest
//
//  Created by Atakan on 30.01.2026.
//

import Foundation
import SwiftUI

enum TaskPriority: Int, Codable, CaseIterable {
    case low = 0
    case medium = 1
    case high = 2
    case veryHigh = 3

    func title(settings: MatrixSettings) -> String {
        switch self {
        case .low:
            return settings.quadrantLowTitle
        case .medium:
            return settings.quadrantMediumTitle
        case .high:
            return settings.quadrantHighTitle
        case .veryHigh:
            return settings.quadrantVeryHighTitle
        }
    }

    var color: Color {
        switch self {
        case .low:
            return Color(.systemGreen)
        case .medium:
            return .yellow
        case .high:
            return .orange
        case .veryHigh:
            return .red
        }
    }

    func icon(settings: MatrixSettings) -> String {
        switch self {
        case .low:
            return settings.quadrantLowIcon
        case .medium:
            return settings.quadrantMediumIcon
        case .high:
            return settings.quadrantHighIcon
        case .veryHigh:
            return settings.quadrantVeryHighIcon
        }
    }
}

enum WeekDay: Int, Codable, CaseIterable, Identifiable {
    
    case sunday = 1
    case monday = 2
    case tuesday = 3
    case wednesday = 4
    case thursday = 5
    case friday = 6
    case saturday = 7

    var id: String {
        switch self {
        case .monday: "Mon"
        case .tuesday: "Tue"
        case .wednesday: "Wed"
        case .thursday: "Thu"
        case .friday: "Fri"
        case .saturday: "Sat"
        case .sunday: "Sun"
        }
    }
}

enum RoutineScheduleType: String, Codable, CaseIterable {
    case daily, weekly, timed
}

enum RoutinePeriodUnit: String, Codable, CaseIterable {
    case day, week, month
}

enum ProjectStatus: String, Codable, CaseIterable {
    case active, completed, archived
}

enum MatrixTimeFilter: Int {
    case daily, weekly, monthly, custom
}
