//
//  NewDailySheetView.swift
//  DailyNest
//
//  Created by Atakan on 11.03.2026.
//

import SwiftUI

struct NewDailySheetView: View {
    @ObservedObject var dailyViewModel: DailyViewModel
    
    init(dailyViewModel : DailyViewModel){
        self.dailyViewModel = dailyViewModel
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    NewDailySheetView(dailyViewModel: DailyViewModel())
}
