//
//  AppStateService.swift
//  DailyNest
//
//  Created by Atakan on 29.04.2026.
//

import Foundation
import Observation

@Observable
final class AppStateService {
    var selectedProject: Project? = nil
    
    init(){
        
    }
    
    func select(_ project: Project?){
        selectedProject = project
    }
    
    var isProjectSelected: Bool {
        selectedProject != nil
    }
    
    var currentTitle: String? {
        selectedProject?.title ?? "All Tasks"
    }
}
