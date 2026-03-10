//
//  RoutineTaskViewModel.swift
//  DailyNest
//
//  Created by Atakan on 10.03.2026.
//

import Foundation
import SwiftData
import Combine

final class RoutineTaskViewModel: ObservableObject {
    
    func createRoutine(_ task : RoutineTask, context : ModelContext) -> Result<Bool,Error>{
        context.insert(task)
        
        do{
            try context.save()
            return .success(true)
        } catch {
            return .failure(error)
        }
    }
    
    func deleteRoutine(_ task : RoutineTask, context : ModelContext) -> Result<Bool,Error>{
        context.delete(task)
        
        do{
            try context.save()
            return .success(true)
        } catch {
            return .failure(error)
        }
    }
    
    func updateRoutine(_ task : RoutineTask, context : ModelContext) -> Result<Bool,Error>{
        do{
            try context.save()
            return .success(true)
        } catch {
            return .failure(error)
        }
    }
}
