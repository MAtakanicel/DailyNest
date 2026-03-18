//
//  VisibleModifier.swift
//  DailyNest
//
//  Created by Atakan on 18.03.2026.
//

import Foundation
import SwiftUI

extension View {
    @ViewBuilder
    func visible(_ state: Bool) -> some View {
        if state{
            self
        }
    }
}
