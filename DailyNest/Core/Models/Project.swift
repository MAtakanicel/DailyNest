//
//  ProjectTask.swift
//  DailyNest
//
//  Created by Atakan on 19.03.2026.
//
import Foundation
import SwiftData


@Model
final class Project {
    var id: UUID = UUID()

    var title: String
    var details: String? // Description
    var icon:String
    var createdAt: Date
    var colorHex: String
    
    var status : ProjectStatus
    
    var isCompleted: Bool
    var completedAt: Date?

    var startDate: Date?
    var deadline: Date?
    
    @Relationship(deleteRule: .cascade)
    var projectTask: [ProjectTask] = []

    init(
        title: String,
        details: String? = nil,
        colorHex:String = AppColors.projectHex,
        startDate: Date? = nil,
        deadline: Date? = nil,
        isCompleted: Bool = false,
        completedAt: Date? = nil
    ) {
        self.title = title
        self.details = details
        self.colorHex = colorHex
        self.isCompleted = isCompleted
        self.completedAt = completedAt
        self.deadline = deadline
        self.startDate = startDate
        self.colorHex = colorHex
        
        // Varsayılanlar
        icon = ""
        status = .active
        createdAt = .now
    }
}

