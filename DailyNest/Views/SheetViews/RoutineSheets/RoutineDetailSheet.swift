//
//  DetailRoutineView.swift
//  DailyNest
//
//  Created by Atakan on 27.03.2026.
//

import SwiftUI

struct RoutineDetailSheet: View {
    let task: Routine

    @Environment(CalendarHelper.self) private var calendarHelper
    @Environment(MatrixSettings.self) private var matrixSettings
    var body: some View {
        
    }
}

#Preview {
    NavigationStack {
       EmptyView()
            .environment(MockData.previewRoutineViewModel)
        .environment(SheetRouter())
        .environment(CalendarHelper())
        .environment(MatrixSettings())
    }
}
