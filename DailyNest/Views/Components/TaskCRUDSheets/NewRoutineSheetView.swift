//
//  NewRoutineSheetView.swift
//  DailyNest
//
//  Created by Atakan on 11.03.2026.
//

import SwiftUI

struct NewRoutineSheetView: View {
    @ObservedObject var routineViewModel: RoutineViewModel

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    NewRoutineSheetView(routineViewModel: RoutineViewModel())
}
