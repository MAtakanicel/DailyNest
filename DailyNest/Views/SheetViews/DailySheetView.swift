//
//  DailySheetView.swift
//  DailyNest
//
//  Created by Atakan on 11.03.2026.
//

import SwiftUI

struct DailySheetView: View {
    let dailyTask : DailyTask?
    
    @Environment(DailyViewModel.self) private var dailyViewModel
    @Environment(SheetRouter.self) private var sheetRouter
    @Environment(\.dismiss) private var dismiss
    
    @State private var isEditing: Bool = false
    @State private var newTitle: String = "s"
    @State private var newDescription: String? = ""
    @State private var newDate: Date = .init()
    @State private var priority: TaskPriority = .medium
    @State private var reminderIsOn: Bool = false
    @State private var reminderTime: Date? = nil
    
    private var isNewDaily: Bool{ sheetRouter.activeSheet == .newDaily ? true : false }

    
    
    var body: some View {
        ZStack {
            AppColors.background.ignoresSafeArea()
                
            VStack(spacing:0){
                navBarTitle
                  
                
                Spacer()
            }
        }
    }
    
    private var navBarTitle : some View{
        HStack(spacing: 0){
            
            Button{ isNewDaily ? dismiss() : dismiss() } label:{
                
            }
            
            if isNewDaily{
                Text("New")
                    .foregroundColor(AppColors.primaryText)
                    .font(.title.bold())
                + Text("Daily Task")
                    .foregroundStyle(AppColors.secondaryText)
                    .italic()
            }
            if case .taskDetail = sheetRouter.activeSheet{
                 Text("\(sheetRouter.activeSheet?.id ?? "")")
            }
        }
    }
}

#Preview {
    NavigationStack {
        DailySheetView(dailyTask: nil)
            .environment(DailyViewModel())
            .environment(SheetRouter())
    }
}
