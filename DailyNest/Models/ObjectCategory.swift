//
//  ObjectCategory.swift
//  DailyNest
//
//  Created by Atakan on 30.03.2026.
//

import Foundation
import SwiftData

@Model
final class ObjectCategory: Identifiable {
    var id: UUID
    
    var isDefault: Bool
    var title: String
    var color : CategoryColor
    var icon : String = ""
    
    @Relationship(deleteRule: .nullify, inverse: \DailyTask.category)
    var dailyTasks: [DailyTask] = []
    @Relationship(deleteRule: .nullify, inverse: \Routine.category)
    var routines: [Routine] = []
    @Relationship(deleteRule: .nullify, inverse: \ProjectTask.category)
    var projectTasks: [ProjectTask] = []
    
    init(
        title: String,
        color: CategoryColor = .blue,
        
        id: UUID = UUID(),
        isDefault: Bool = false
    ) {
        self.isDefault = isDefault
        self.id = id
        
        self.title = title
        self.color = color
    }
}
