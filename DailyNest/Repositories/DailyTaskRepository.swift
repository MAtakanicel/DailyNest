//
//  DailyTaskRepository.swift
//  DailyNest
//
//  Created by Atakan on 4.04.2026.
//

import Foundation
import SwiftData
import Observation

protocol DailyTaskRepositoryProtocol{
    func create(_ task: DailyTask) throws
    func update(_ task: DailyTask) throws
    func delete(_ task: DailyTask) throws
}

@Observable
class DailyTaskRepository: DailyTaskRepositoryProtocol{
    
    private let context : ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func create(_ task: DailyTask) throws {
        context.insert(task)
        try persist()
    }
    
    func update(_ task: DailyTask) throws {
        try persist()
    }
        
    func delete(_ task: DailyTask) throws {
        context.delete(task)
        try persist()
    }
    
        
    private func persist() throws {
        try context.save()
    }
}
        
