//
//  SectionDevider.swift
//  DailyNest
//
//  Created by Atakan on 27.03.2026.
//

import SwiftUI

enum SectionDividerType{
    case top, regular, bottom
}

struct SectionDivider: View {
    let deviderType: SectionDividerType
    var body: some View {
        switch deviderType {
        case .top:
            Divider()
                .opacity(0.5)
                .padding(.horizontal, 15)
                .padding(.bottom,10)

        case .regular:
            Divider()
                .opacity(0.5)
                .padding(.horizontal, 30)
                .padding(.vertical, 15)
       
        case .bottom:
            Divider()
                .opacity(0.5)
                .padding(.horizontal, 15)
                .padding(.top,10)
        }
        
    }
}

