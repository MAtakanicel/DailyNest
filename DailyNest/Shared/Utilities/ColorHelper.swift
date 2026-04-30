//
//  ColorHelper.swift
//  DailyNest
//
//  Created by Atakan on 26.04.2026.
//

import Foundation
import SwiftUI


enum ColorHelper {
    static let palette: [String] = [
          AppColors.projectHex,
          AppColors.dailyHex,
          AppColors.routineHex,
          AppColors.categoryHex,
          "#D85A30", "#D4537E",
          "#639922", "#E24B4A",
          "#888780", "#185FA5"
      ]
    
    static func convertColor(from hex: String) -> Color{
        Color(UIColor(hex: hex))
    }
    
    static func randomColor() -> String {
         palette.randomElement() ?? AppColors.projectHex
     }
}
