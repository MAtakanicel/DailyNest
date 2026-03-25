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
    var dailyTask : DailyTask
    
    @Environment(DailyViewModel.self) private var dailyViewModel
    @Environment(SheetRouter.self) private var sheetRouter
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var isAlertShown: Bool = false
    @State private var mode: DetailSheetMode = .edit
    
    @State private var newTitle: String = ""
    @State private var newDescription: String = ""
    @State private var newDate: Date = .init()
    @State private var priority: TaskPriority = .medium
    @State private var reminderIsOn: Bool = false
    @State private var reminderDate: Date = .init()
    

    init(dailyTask: DailyTask){
        self.dailyTask = dailyTask
       // _mode = State(initialValue: dailyTask == nil ? .create : .detail)
    }
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                AppColors.background.ignoresSafeArea()
                
                VStack(spacing:0){
                    
                    forms
                        .padding(.horizontal,20)
                    
                    Spacer()
                }
                .padding(.top,5)
            }
            .alert("Are you sure ?",isPresented: $isAlertShown) {
                Button("Cancel", role: .cancel){
                    isAlertShown.toggle()
                }
                
                Button("Confirm",role: .destructive){
                    dailyViewModel.deleteDaily(dailyTask, context: context)
                }
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .topBarLeading){ navBarBackButton }
                ToolbarItem(placement: .title){ navBarTitle }
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
                    .foregroundColor(AppColors.primaryText)
            }
        case .detail:
            
            Button{ isAlertShown.toggle() } label: {
                Image(systemName: "trash")
                    .foregroundColor(.red.opacity(0.9))
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white.opacity(0.8))

            }
        case .edit:
            Button{ mode = .detail } label: {
                Text("Back")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white.opacity(0.8))
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
            Text(dailyTask.title)
                .font(.title3.italic())
                .foregroundColor(AppColors.primaryText)
                .lineLimit(1)
        case .edit:
            VStack(spacing: 0) {
                Text(dailyTask.title)
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
                dailyViewModel.createDaily(
                    title: newTitle ,
                    details: newDescription,
                    date: newDate,
                    priority: priority,
                    isReminderOn: reminderIsOn,
                    reminderDate: reminderDate,
                    context: context
                )
            } label:{
                Text("Create")
                    .font(.title3)
                    .foregroundColor(dailyViewModel.newDailyValid(title: newTitle) ? AppColors.button : .gray.opacity(0.35))
            }
            .disabled(dailyViewModel.newDailyValid(title: newTitle))
            
        case .detail:
                Button{ mode = .edit } label:{
                    Text("Edit")
                        .foregroundColor(AppColors.button)
                }
        case .edit:
                Button{ dailyViewModel.updateDaily(dailyTask, context: context) } label: {
                    Text("Done")
                        .foregroundColor(AppColors.button)
                }
        }
    }
    
    @ViewBuilder
    private var forms: some View {
        ScrollView {
            switch mode {
            case .create:
                VStack(alignment: .leading,spacing:0){
                    TextField("Task title", text: $newTitle)
                        .foregroundColor(AppColors.primaryText)
                        .lineLimit(1)
                        .padding(10)
                        .background(
                            Capsule()
                                .fill(.gray.opacity(0.1))
                                .stroke(AppColors.overlayStroke.opacity(0.15), lineWidth: 0.5)
                        )
                    
                    Divider()
                        .opacity(0.5)
                        .padding(.vertical,15)
                        .padding(.horizontal,30)
                    
                    ZStack(alignment:.topLeading){
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.gray.opacity(0.1))
                            .stroke(AppColors.overlayStroke.opacity(0.15), lineWidth: 0.5)
                        
                        Text("Description (optional)")
                            .foregroundColor(AppColors.secondaryText)
                            .font(.caption)
                            .padding(8)
                            .padding(.top,6)
                            .visible(newDescription.isEmpty)
                        
                        TextEditor(text: $newDescription)
                            .foregroundColor(AppColors.primaryText)
                            .font(.caption)
                            .padding(4)
                            .frame(height: 150)
                            .textEditorStyle(.plain)
                    }
                    
                    Divider()
                        .opacity(0.5)
                        .padding(.top,15)
                        .padding(.bottom, 8)
                        .padding(.horizontal,30)
                    
                    HStack(spacing: 0){
                        
                        Text("Date: ")
                            .font(.headline.bold())
                            .foregroundColor(AppColors.primaryText)
                            .padding(.trailing,5)
 
                        DatePicker("", selection: $newDate, displayedComponents: .date)
                            .datePickerStyle(.compact)
                            .labelsHidden()
    
                    }
                    
                    Divider()
                        .opacity(0.5)
                        .padding(.vertical,15)
                        .padding(.horizontal,30)
                    
                    PrioritySection(selected: $priority)
                        
                    Divider()
                        .opacity(0.5)
                        .padding(.vertical,15)
                        .padding(.horizontal,30)
                    
                    HStack(spacing: 0){
                        Text("Reminder:")
                            .foregroundColor(AppColors.primaryText)
                            .font(Font.headline.bold())
                            .padding(.trailing, 10)
                        
                        Toggle("", isOn: $reminderIsOn.animation(.easeInOut(duration: 0.5)))
                            .labelsHidden()
                    }
                    .padding(.bottom, 10)
                    HStack {
                        Spacer()
                        DatePicker("",selection: $reminderDate)
                            .labelsHidden()
                            .datePickerStyle(.wheel)
                        Spacer()
                    }
                    .transition(.opacity.combined(with: .opacity))
                    .visible(reminderIsOn)
                }
                .transition(.opacity.combined(with: .opacity))
                .padding(.horizontal, 10)
            case .detail:
                VStack(spacing:0){
                    
                }
            case .edit:
                if let task = dailyTask {
                    @Bindable var bindableTask = task
                }
                VStack(spacing:0){
                    VStack(alignment: .leading,spacing:0){
                        TextField("Task title", text: )
                            .foregroundColor(AppColors.primaryText)
                            .lineLimit(1)
                            .padding(10)
                            .background(
                                Capsule()
                                    .fill(.gray.opacity(0.1))
                                    .stroke(AppColors.overlayStroke.opacity(0.15), lineWidth: 0.5)
                            )
                        
                        Divider()
                            .opacity(0.5)
                            .padding(.vertical,15)
                            .padding(.horizontal,30)
                        
                        ZStack(alignment:.topLeading){
                            RoundedRectangle(cornerRadius: 16)
                                .fill(.gray.opacity(0.1))
                                .stroke(AppColors.overlayStroke.opacity(0.15), lineWidth: 0.5)
                            
                            Text("Description (optional)")
                                .foregroundColor(AppColors.secondaryText)
                                .font(.caption)
                                .padding(8)
                                .padding(.top,6)
                                .visible(newDescription.isEmpty)
                            
                            TextEditor(text: $newDescription)
                                .foregroundColor(AppColors.primaryText)
                                .font(.caption)
                                .padding(4)
                                .frame(height: 150)
                                .textEditorStyle(.plain)
                        }
                        
                        Divider()
                            .opacity(0.5)
                            .padding(.top,15)
                            .padding(.bottom, 8)
                            .padding(.horizontal,30)
                        
                        HStack(spacing: 0){
                            
                            Text("Date: ")
                                .font(.headline.bold())
                                .foregroundColor(AppColors.primaryText)
                                .padding(.trailing,5)
     
                            DatePicker("", selection: $newDate, displayedComponents: .date)
                                .datePickerStyle(.compact)
                                .labelsHidden()
        
                        }
                        
                        Divider()
                            .opacity(0.5)
                            .padding(.vertical,15)
                            .padding(.horizontal,30)
                        
                        PrioritySection(selected: $priority)
                            
                        Divider()
                            .opacity(0.5)
                            .padding(.vertical,15)
                            .padding(.horizontal,30)
                        
                        HStack(spacing: 0){
                            Text("Reminder:")
                                .foregroundColor(AppColors.primaryText)
                                .font(Font.headline.bold())
                                .padding(.trailing, 10)
                            
                            Toggle("", isOn: $reminderIsOn.animation(.easeInOut(duration: 0.5)))
                                .labelsHidden()
                        }
                        .padding(.bottom, 10)
                        HStack {
                            Spacer()
                            DatePicker("",selection: $reminderDate)
                                .labelsHidden()
                                .datePickerStyle(.wheel)
                            Spacer()
                        }
                        .transition(.opacity.combined(with: .opacity))
                        .visible(reminderIsOn)
                    }
                    .transition(.opacity.combined(with: .opacity))
                    .padding(.horizontal, 10)
                }
            }
        }
        
    }
    
}

#Preview {
    NavigationStack {
        DailySheetView(dailyTask: DailyTask(
            title: "Buy groceries",
            details: "Milk, eggs, bread",
            date: .now,
            priority: .medium
        ))
            .environment(DailyViewModel())
            .environment(SheetRouter())
            .environment(MatrixSettings())
    }
}
