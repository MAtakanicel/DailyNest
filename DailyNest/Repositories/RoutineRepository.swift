//
//  RoutineRepository.swift
//  DailyNest
//
//  Created by Atakan on 4.04.2026.
//

import Foundation
import SwiftData

protocol RoutineRepositoryProtocol{
    func create(_ routine: Routine) throws
    func update(_ routine: Routine) throws
    func delete(_ routine: Routine) throws
}

class RoutineRepository: RoutineRepositoryProtocol {
    private let context : ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func create(_ routine: Routine) throws {
        context.insert(routine)
        try persist()
    }
    
    func update(_ routine: Routine) throws {
        try persist()
    }
    
    func delete(_ routine: Routine) throws {
        context.delete(routine)
        try persist()
    }
    
    private func persist() throws {
        try context.save()
    }
}
