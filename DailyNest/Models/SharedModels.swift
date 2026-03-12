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

    var title: String {
        switch self {
        case .low:
            return "Low"
        case .medium:
            return "Medium"
        case .high:
            return "High"
        case .veryHigh:
            return "Very High"
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
}

enum WeekDay: Int, Codable, CaseIterable {
    case sunday = 1
    case monday = 2
    case tuesday = 3
    case wednesday = 4
    case thursday = 5
    case friday = 6
    case saturday = 7

    var shortName: String {
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
