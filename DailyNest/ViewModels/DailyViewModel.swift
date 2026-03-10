//
//  TaskViewModel.swift
//  DailyNest
//
//  Created by Atakan on 10.03.2026.
//

import Foundation
import Combine
import SwiftData

final class DailyViewModel : ObservableObject {
    
    func createDaily(_ task : DailyTask, context: ModelContext) -> Result<Bool, Error> {
        context.insert(task)
        do{
            try context.save()
            return .success(true)
        }catch{
            return .failure(error)
        }
        
    }
    
    
    func deleteDaily(_ task : DailyTask, context : ModelContext) -> Result<Bool, Error> {
        context.delete(task)
        do{
            try context.save()
            return .success(true)
        }catch {
            return .failure(error)
        }
    }
    
    func updateDaily(_ task : DailyTask, context: ModelContext) -> Result<Bool, Error> {
        do {
            try context.save()
            return .success(true)
        }catch {
            return .failure(error)
        }
    }
    
    
}
