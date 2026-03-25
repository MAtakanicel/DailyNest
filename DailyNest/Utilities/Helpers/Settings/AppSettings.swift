//
//  AppSettings.swift
//  DailyNest
//
//  Created by Atakan on 24.03.2026.
//

import Foundation
import Observation

enum AppSettingsKeys {
    static let routineExpanded = "routineSection_expanded"
    static let pastExpanded = "pastSection_expanded"
    static let todayExpanded = "todaySection_expanded"
    static let completedExpanded = "completedSection_expanded"
    
    static let routineSectionHidden = "routineSection_isHidden"
    static let pastSectionHidden = "pastSection_isHidden"
    static let todaySectionHidden = "todaySection_isHidden"
    static let completedSectionHidden = "completedSection_isHidden"
}


@Observable
class AppSettings {
    // Section Açık mı Kapalı mı ? Default: false (collapsed)
    var routineSectionIsExpanded: Bool = UserDefaults.standard.bool(forKey: AppSettingsKeys.routineExpanded) {
        didSet { UserDefaults.standard.set(routineSectionIsExpanded, forKey: AppSettingsKeys.routineExpanded) }
    }
    var pastSectionIsExpanded: Bool = UserDefaults.standard.bool(forKey: AppSettingsKeys.pastExpanded){
        didSet{ UserDefaults.standard.set(pastSectionIsExpanded, forKey: AppSettingsKeys.pastExpanded) }
    }
    var todaySectionIsExpanded: Bool = UserDefaults.standard.bool(forKey: AppSettingsKeys.todayExpanded){
        didSet{ UserDefaults.standard.set(todaySectionIsExpanded, forKey: AppSettingsKeys.todayExpanded) }
    }
    var completedSectionIsExpanded: Bool = UserDefaults.standard.bool(forKey: AppSettingsKeys.completedExpanded){
        didSet{ UserDefaults.standard.set(completedSectionIsExpanded, forKey: AppSettingsKeys.completedExpanded) }
    }

    // Section görünür mü ?
    var routineSectionIsHidden: Bool = UserDefaults.standard.object(forKey: AppSettingsKeys.routineSectionHidden)as? Bool ?? true {
        didSet{ UserDefaults.standard.set(routineSectionIsHidden, forKey: AppSettingsKeys.routineSectionHidden) }
    }
    var pastSectionIsHidden: Bool = UserDefaults.standard.object(forKey: AppSettingsKeys.pastSectionHidden) as? Bool ?? true{
        didSet{ UserDefaults.standard.set(pastSectionIsHidden, forKey: AppSettingsKeys.pastSectionHidden) }
    }
    var completedSectionIsHidden: Bool = UserDefaults.standard.object(forKey: AppSettingsKeys.completedSectionHidden) as? Bool ?? true{
        didSet{ UserDefaults.standard.set(completedSectionIsHidden, forKey: AppSettingsKeys.completedSectionHidden) }
    }
    var todaySectionIsHidden: Bool = UserDefaults.standard.object(forKey: AppSettingsKeys.todaySectionHidden) as? Bool ?? true{
        didSet{ UserDefaults.standard.set(todaySectionIsHidden, forKey: AppSettingsKeys.todaySectionHidden)  }
    }
 
}
