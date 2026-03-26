//
//  MatrixSettings.swift
//  DailyNest
//
//  Created by Atakan on 24.03.2026.
//

import Foundation
import Observation

enum MatrixSettingsKeys {
    static let quadrantTimefilterState = "matrixTimeFilter"
    static let quadrantColorIsShown = "matrixColorIsShown"

    static let quadrantVeryHighTitle = "quadrantTitle_veryHighTitle"
    static let quadrantHighTitle = "quadrantTitle_highTitle"
    static let quadrantMediumTitle = "quadrantTitle_mediumTitle"
    static let quadrantLowTitle = "quadrantTitle_lowTitle"

    static let quadrantVeryHighIcon = "quadrantIcon_veryHighIcon"
    static let quadrantHighIcon = "quadrantIcon_highIcon"
    static let quadrantMediumIcon = "quadrantIcon_mediumIcon"
    static let quadrantLowIcon = "quadrantIcon_lowIcon"
}

@Observable
class MatrixSettings {
    var quadrantMatrixColorIsShown: Bool = UserDefaults.standard.object(forKey: MatrixSettingsKeys.quadrantColorIsShown) as? Bool ?? true {
        didSet { UserDefaults.standard.set(quadrantMatrixColorIsShown, forKey: MatrixSettingsKeys.quadrantColorIsShown) }
    }

    // MARK: - Kadranların başlığı

    var quadrantVeryHighTitle: String = UserDefaults.standard.string(forKey: MatrixSettingsKeys.quadrantVeryHighTitle) ?? "Very High" {
        didSet { UserDefaults.standard.set(quadrantVeryHighTitle, forKey: MatrixSettingsKeys.quadrantVeryHighTitle) }
    }

    var quadrantHighTitle: String = UserDefaults.standard.string(forKey: MatrixSettingsKeys.quadrantHighTitle) ?? "High" {
        didSet { UserDefaults.standard.set(quadrantHighTitle, forKey: MatrixSettingsKeys.quadrantHighTitle) }
    }

    var quadrantMediumTitle: String = UserDefaults.standard.string(forKey: MatrixSettingsKeys.quadrantMediumTitle) ?? "Medium" {
        didSet { UserDefaults.standard.set(quadrantMediumTitle, forKey: MatrixSettingsKeys.quadrantMediumTitle) }
    }

    var quadrantLowTitle: String = UserDefaults.standard.string(forKey: MatrixSettingsKeys.quadrantLowTitle) ?? "Low" {
        didSet { UserDefaults.standard.set(quadrantLowTitle, forKey: MatrixSettingsKeys.quadrantLowTitle) }
    }

    // MARK: - Kadran ikonu

    var quadrantVeryHighIcon: String = UserDefaults.standard.string(forKey: MatrixSettingsKeys.quadrantVeryHighIcon) ?? "🔴" {
        didSet { UserDefaults.standard.set(quadrantVeryHighIcon, forKey: MatrixSettingsKeys.quadrantVeryHighIcon) }
    }

    var quadrantHighIcon: String = UserDefaults.standard.string(forKey: MatrixSettingsKeys.quadrantHighIcon) ?? "🟠" {
        didSet { UserDefaults.standard.set(quadrantHighIcon, forKey: MatrixSettingsKeys.quadrantHighIcon) }
    }

    var quadrantMediumIcon: String = UserDefaults.standard.string(forKey: MatrixSettingsKeys.quadrantMediumIcon) ?? "🟡" {
        didSet { UserDefaults.standard.set(quadrantMediumIcon, forKey: MatrixSettingsKeys.quadrantMediumIcon) }
    }

    var quadrantLowIcon: String = UserDefaults.standard.string(forKey: MatrixSettingsKeys.quadrantLowIcon) ?? "🟢" {
        didSet { UserDefaults.standard.set(quadrantLowIcon, forKey: MatrixSettingsKeys.quadrantLowIcon) }
    }
}
