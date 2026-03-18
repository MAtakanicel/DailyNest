//
//  AgendaView.swift
//  DailyNest
//
//  Created by Atakan on 30.01.2026.
//

import SwiftUI
import SwiftData

struct Agenda: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    TabBar(selectedTab: .agenda)
        .modelContainer(MockData.previewContainer)
        .environment(HomeViewModel())
        .environment(DailyViewModel())
        .environment(RoutineViewModel())
        .environment(SheetRouter())
}
