//
//  DailySheetView.swift
//  DailyNest
//
//  Created by Atakan on 11.03.2026.
//

import SwiftUI

enum DetailSheetMode{
    case create
    case detail
    case edit
}

struct DailySheetView: View {
    @State private var task: DailyTask
    
    @Environment(DailyViewModel.self) private var dailyViewModel
    @Environment(SheetRouter.self) private var sheetRouter
    @Environment(CalendarHelper.self) private var calendarHelper
    @Environment(MatrixSettings.self) private var matrixSettings
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var isAlertShown: Bool = false
    @State private var mode: DetailSheetMode
    
    init(dailyTask: DailyTask,mode: DetailSheetMode){
        _mode = State(initialValue: mode)
        _task = State(initialValue: dailyTask)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                AppColors.background.ignoresSafeArea()
                
                forms
                    .padding(.horizontal,20)
                    .animation(.smooth(duration: 0.5), value: mode)
                    .padding(.top,5)
                
            }
            .alert("Delete '\(task.title)'?", isPresented: $isAlertShown) {
                Button("Cancel", role: .cancel){
                    isAlertShown.toggle()
                }
                
                Button("Confirm",role: .destructive){
                    dailyViewModel.deleteDaily(task, context: context)
                  
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                        dismiss()
                    }
                }
            } message: {
                Text("This action cannot be undone.")
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .topBarLeading){ navBarBackButton }
                ToolbarItem(placement: .principal){ navBarTitle }
                ToolbarItem(placement: .topBarTrailing){ navBarDoneButton }
                  
            }
        }
    }
        
    @ViewBuilder
    private var navBarBackButton: some View {
        switch mode{
        case .create:
            Button{ dismiss() } label: {
                Text("Cancel")
                    .foregroundColor(.red.opacity(0.9))
                    .font(.title3)
                   
            }
        case .detail:
            Button{ isAlertShown.toggle() } label: {
                Image(systemName: "trash")
                    .foregroundColor(.red.opacity(0.9))
                    .font(.title3)
                    .bold()
            }
        case .edit:
            Button{ mode = .detail } label: {
                Text("Back")
                    .font(.title3)
                    .foregroundColor(AppColors.primaryText)
            }
        }
    }
   
    @ViewBuilder
    private var navBarTitle: some View {
        switch mode{
        case .create:
            HStack(spacing: 0){
                Text("New")
                    .foregroundColor(AppColors.primaryText)
                    .font(.title2.bold())
                    .padding(.trailing,3)
                    
                 Text("Daily Task")
                    .foregroundStyle(AppColors.secondaryText)
                    .italic()
                    .padding(.top,2)
            }
        case .detail:
            Text(task.title)
                .font(.title3.italic())
                .foregroundColor(AppColors.primaryText)
                .lineLimit(1)
         
        case .edit:
            VStack(spacing: 0) {
                Text(task.title)
                    .font(.title3.italic())
                    .foregroundColor(AppColors.primaryText)
                    .lineLimit(1)
                
                Text("Editing")
                    .font(.caption)
                    .foregroundColor(AppColors.secondaryText)
            }
        }
    }
   
    @ViewBuilder
    private var navBarDoneButton: some View {
        switch mode{
        case .create:
            Button{
                dailyViewModel.createDaily(task: task, context: context)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                    dismiss()
                }
            } label:{
                Text("Create")
                    .font(.title3)
                    .foregroundColor(dailyViewModel.newDailyValid(title: task.title) ? AppColors.button : .gray.opacity(0.35))
            }
            .disabled(!dailyViewModel.newDailyValid(title: task.title))
            
        case .detail:
                Button{ mode = .edit } label:{
                    Text("Edit")
                        .font(.title3)
                        .foregroundColor(AppColors.button)
                }
        case .edit:
                Button{
                    dailyViewModel.updateDaily(task, context: context)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                        mode = .detail
                    }
                } label: {
                    Text("Done")
                        .font(.title3)
                        .foregroundColor(AppColors.button)
                }
        }
    }
    
    @ViewBuilder
    private var forms: some View {
        ScrollView {
            switch mode {
            case .detail:
                DailyDetailView(task: task)
                    .padding(.horizontal, 10)
                
            case .create, .edit:
                VStack(alignment: .leading,spacing:0){
                    
                    sectionDivider
                    
                    DailyTitleField(task: $task)
                    
                    sectionDivider
                    
                    DailyDescriptionField(task: $task)
                    
                    sectionDivider
                    
                    DailyDateSection(task: $task)
                    
                    sectionDivider
                    
                    PrioritySection(selected: $task.priority)
                    
                    sectionDivider
                    
                    DailyReminderSection(task: $task)
                }
                .padding(.horizontal, 10)
            }
        }
    }
    private var sectionDivider: some View {
        Divider()
            .opacity(0.5)
            .padding(.vertical, 15)
            .padding(.horizontal, 30)
    }
}

#Preview {
    NavigationStack {
        DailySheetView(dailyTask: DailyTask(
            title: "Buy groceries",
            details: "Milk, eggs, bread",
            date: .now,
            priority: .veryHigh,
            isReminderOn: true
        ),
                       mode: .detail
        )
            .environment(DailyViewModel())
            .environment(SheetRouter())
            .environment(MatrixSettings())
            .environment(CalendarHelper())
    }
}
