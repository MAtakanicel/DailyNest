//
//  File.swift
//  DailyNest
//
//  Created by Atakan on 26.04.2026.
//

import Foundation
import SwiftData

protocol ProjectRepositoryProtocol {
    func create(_ project: Project) throws
    func update(_ project: Project) throws
    func delete(_ project: Project) throws
}

final class ProjectRepository: ProjectRepositoryProtocol {
    private let context : ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func create(_ project: Project) throws {
        context.insert(project)
        try persist()
    }
    
    func update(_ project: Project) throws {
        try persist()
    }
    
    func delete(_ project: Project) throws {
        context.delete(project)
        try persist()
    }
    
    
    private func persist() throws {
        try context.save()
    }
}
