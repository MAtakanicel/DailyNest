//
//  MainPageSettings.swift
//  DailyNest
//
//  Created by Atakan on 24.03.2026.
//

import Foundation
import Observation

enum MainPageSettingsKeys {
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
class MainPageSettings {
    /// Section Açık mı Kapalı mı ? Default: false (collapsed)
    var routineSectionIsExpanded: Bool = UserDefaults.standard.bool(forKey: MainPageSettingsKeys.routineExpanded) {
        didSet { UserDefaults.standard.set(routineSectionIsExpanded, forKey: MainPageSettingsKeys.routineExpanded) }
    }

    var pastSectionIsExpanded: Bool = UserDefaults.standard.bool(forKey: MainPageSettingsKeys.pastExpanded) {
        didSet { UserDefaults.standard.set(pastSectionIsExpanded, forKey: MainPageSettingsKeys.pastExpanded) }
    }

    var todaySectionIsExpanded: Bool = UserDefaults.standard.bool(forKey: MainPageSettingsKeys.todayExpanded) {
        didSet { UserDefaults.standard.set(todaySectionIsExpanded, forKey: MainPageSettingsKeys.todayExpanded) }
    }

    var completedSectionIsExpanded: Bool = UserDefaults.standard.bool(forKey: MainPageSettingsKeys.completedExpanded) {
        didSet { UserDefaults.standard.set(completedSectionIsExpanded, forKey: MainPageSettingsKeys.completedExpanded) }
    }

    /// Section görünür mü ?
    var routineSectionIsHidden: Bool = UserDefaults.standard.bool(forKey: MainPageSettingsKeys.routineSectionHidden) {
        didSet { UserDefaults.standard.set(routineSectionIsHidden, forKey: MainPageSettingsKeys.routineSectionHidden) }
    }

    var pastSectionIsHidden: Bool = UserDefaults.standard.bool(forKey: MainPageSettingsKeys.pastSectionHidden) {
        didSet { UserDefaults.standard.set(pastSectionIsHidden, forKey: MainPageSettingsKeys.pastSectionHidden) }
    }

    var completedSectionIsHidden: Bool = UserDefaults.standard.bool(forKey: MainPageSettingsKeys.completedSectionHidden) {
        didSet { UserDefaults.standard.set(completedSectionIsHidden, forKey: MainPageSettingsKeys.completedSectionHidden) }
    }

    var todaySectionIsHidden: Bool = UserDefaults.standard.bool(forKey: MainPageSettingsKeys.todaySectionHidden) {
        didSet { UserDefaults.standard.set(todaySectionIsHidden, forKey: MainPageSettingsKeys.todaySectionHidden) }
    }
}
