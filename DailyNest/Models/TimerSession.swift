//
//  TimerSession.swift
//  DailyNest
//
//  Created by Atakan on 15.03.2026.
//

import Foundation
import SwiftData

protocol Taskable {
    var id: UUID { get }
    var title: String { get }
    var priority: TaskPriority { get }
    var isCompleted: Bool { get }
    var completedAt: Date? { get }
}

@Model
final class TimerSession {
    var startTime: Date
    var duration: Int

    var linkedDaily: DailyTask?
    var linkedRoutine: Routine?

    init(
        startTime: Date,
        duration: Int = 0,
        linkedDaily: DailyTask? = nil,
        linkedRoutine: Routine? = nil
    ) {
        self.startTime = startTime
        self.duration = duration
        self.linkedDaily = linkedDaily
        self.linkedRoutine = linkedRoutine
    }
}
