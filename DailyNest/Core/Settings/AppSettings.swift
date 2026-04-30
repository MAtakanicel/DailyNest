//
//  AppSettings.swift
//  DailyNest
//
//  Created by Atakan on 22.04.2026.
//

import Foundation
import Observation

enum AppSettingsKeys{
    static let  userName = "userName"
    static let  isDarkModeEnabled = "isDarkModeEnabled"
    static let defaultProjectID = "defaultProjectID"
}

@Observable
class AppSettings {
    var userName: String = UserDefaults.standard.string(forKey: AppSettingsKeys.userName) ?? "" {
        didSet { UserDefaults.standard.set(userName, forKey: AppSettingsKeys.userName) }
    }
    
    var defaultProjectID: String = UserDefaults.standard.string(forKey: AppSettingsKeys.defaultProjectID) ?? "" {
           didSet { UserDefaults.standard.set(defaultProjectID, forKey: AppSettingsKeys.defaultProjectID) }
       }
}
