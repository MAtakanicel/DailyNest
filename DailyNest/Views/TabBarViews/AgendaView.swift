//
//  AgendaView.swift
//  DailyNest
//
//  Created by Atakan on 30.01.2026.
//

import SwiftData
import SwiftUI

struct Agenda: View {
    @Environment(CalendarHelper.self) private var calendarHelper
    @Environment(DailyViewModel.self) private var dailyViewModel
    @Environment(SheetRouter.self) private var sheetRouter
    @Environment(\.modelContext) private var context
    
    var body: some View {
        
    }
    
    private func calendar() -> some View {
        HStack{
            
        }.gesture(){
            
        }
    }
}

#Preview {
    TabBar(selectedTab: .agenda)
        .modelContainer(MockData.previewContainer)
        .environment(HomeViewModel())
        .environment(DailyViewModel())
        .environment(RoutineViewModel())
        .environment(SheetRouter())
        .environment(CalendarHelper())
}
