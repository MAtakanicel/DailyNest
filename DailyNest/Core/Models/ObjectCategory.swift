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
    var colorHex :String
    var icon : String = ""
    
    @Relationship(deleteRule: .nullify, inverse: \DailyTask.category)
    var dailyTasks: [DailyTask] = []
    @Relationship(deleteRule: .nullify, inverse: \Routine.category)
    var routines: [Routine] = []
    
    init(
        title: String,
        colorHex: String = AppColors.categoryHex,
        
        id: UUID = UUID(),
        isDefault: Bool = false
    ) {
        self.isDefault = isDefault
        self.id = id
        
        self.title = title
        self.colorHex = colorHex
    }
}
