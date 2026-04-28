//
//  ColorHelper.swift
//  DailyNest
//
//  Created by Atakan on 26.04.2026.
//

import Foundation
import SwiftUI


enum ColorHelper {
    static func convertColor(from hex: String) -> Color{
        Color(UIColor(hex: hex))
    }
}
