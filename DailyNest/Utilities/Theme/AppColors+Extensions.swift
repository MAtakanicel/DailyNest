import Foundation
import SwiftUI

extension AppColors {
    static let sectionBackgroundStart = Color(UIColor { trait in
        if trait.userInterfaceStyle == .dark {
            return UIColor(red: 55/255, green: 55/255, blue: 60/255, alpha: 1)
        } else {
            return UIColor(red: 248/255, green: 248/255, blue: 252/255, alpha: 1)
        }
    })
    
    static let sectionBackgroundEnd = Color(UIColor { trait in
        if trait.userInterfaceStyle == .dark {
            return UIColor(red: 25/255, green: 25/255, blue: 30/255, alpha: 1)
        } else {
            return UIColor(red: 232/255, green: 232/255, blue: 238/255, alpha: 1)
        }
    })
}
