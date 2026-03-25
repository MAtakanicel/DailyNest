//
//  DailySheetView.swift
//  DailyNest
//
//  Created by Atakan on 11.03.2026.
//

import SwiftUI

enum DetailSheedMode{
    case create
    case detail
    case edit
}

struct DailySheetView: View {
    let dailyTask : DailyTask?
    
    @Environment(DailyViewModel.self) private var dailyViewModel
    @Environment(SheetRouter.self) private var sheetRouter
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var isAlertShown: Bool = false
    @State private var mode: DetailSheedMode = .create
    
    @State private var newTitle: String = ""
    @State private var newDescription: String = ""
    @State private var newDate: Date = .init()
    @State private var priority: TaskPriority = .medium
    @State private var reminderIsOn: Bool = false
    @State private var reminderTime: Date? = nil
    
    @State private var selected: TaskPriority = .medium

    init(dailyTask: DailyTask?){
        self.dailyTask = dailyTask
       // _mode = State(initialValue: dailyTask == nil ? .create : .detail)
    }
    
    
    var body: some View {
        ZStack {
            AppColors.background.ignoresSafeArea()
                
            VStack(spacing:0){
                navBar
                    .padding(.horizontal,20)
                    .padding(.bottom,10)
                  
                forms
                    .padding(.horizontal,20)
                
                Spacer()
            }
        }
        .alert("Are you sure ?",isPresented: $isAlertShown) {
            Button("Cancel", role: .cancel){
                isAlertShown.toggle()
            }
            
            Button("Confirm",role: .destructive){
                dailyViewModel.deleteDaily(dailyTask!, context: context)
            }
            
        }
    }
    
    @ViewBuilder
    private var navBar : some View{
        
        switch mode {
        case .create:
           HStack(spacing: 0){
               
               Button{ mode = .detail } label: {
                   Image(systemName: "xmark")
                       .font(.title2)
                       .bold()
                       .foregroundColor(.white.opacity(0.8))
                       .padding(.horizontal,6)
                       .padding(8)
                       .background(
                          Capsule()
                              .fill(.red)
                              .stroke(AppColors.overlayStroke.opacity(0.1), lineWidth: 0.1)
                       )
               }
              
               Spacer()
               
              Text("New")
                  .foregroundColor(AppColors.primaryText)
                  .font(.title2.bold())
                  .padding(.trailing,3)
                  
               Text("Daily Task")
                  .foregroundStyle(AppColors.secondaryText)
                  .italic()
                  .padding(.top,2)
              
               Spacer()
               
               Button{ /* ekleme fonk */ } label:{
                   Image(systemName: "plus")
                       .font(.title3)
                       .bold()
                       .foregroundColor(AppColors.primaryText)
                       .padding(10)
                       .padding(.horizontal,6)
                       .background(
                          Capsule()
                              .fill(AppColors.button)
                              .stroke(AppColors.overlayStroke.opacity(0.1), lineWidth: 0.1)
                       )
               }
               
            }
        case .detail:
             HStack(spacing: 0){
                 
                 Button{ isAlertShown.toggle() } label: {
                     Image(systemName: "trash")
                         .font(.title2)
                         .bold()
                         .foregroundColor(.white.opacity(0.8))
                         .padding(8)
                         .background(
                            Circle()
                                .fill(.red)
                                .stroke(AppColors.overlayStroke.opacity(0.1), lineWidth: 0.1)
                         )
                     
                 }
                 
                 Spacer()
                 
                 Text(dailyTask!.title)
                     .font(.title3.italic())
                     .foregroundColor(AppColors.primaryText)
                     .lineLimit(1)
                 
                 Spacer()
                 
                 Button{ mode = .edit } label:{
                     Text("Edit")
                         .foregroundColor(AppColors.primaryText)
                         .padding(10)
                         .background(
                            Capsule()
                                .fill(AppColors.button)
                                .stroke(AppColors.overlayStroke.opacity(0.1), lineWidth: 0.1)
                         )
                 }
                 
              }
        case .edit:
             HStack(spacing: 0){
                 
                 Button{ mode = .detail } label: {
                     Image(systemName: "xmark")
                         .font(.title2)
                         .bold()
                         .foregroundColor(.white.opacity(0.8))
                         .padding(8)
                         .padding(.horizontal,6)
                         .background(
                            Capsule()
                                .fill(.red)
                                .stroke(AppColors.overlayStroke.opacity(0.1), lineWidth: 0.1)
                         )
                 }
                 
                 Spacer()
                 
                 VStack(spacing: 0) {
                     Text(dailyTask!.title)
                         .font(.title3.italic())
                         .foregroundColor(AppColors.primaryText)
                         .lineLimit(1)
                     
                     Text("Editing")
                         .font(.caption)
                         .foregroundColor(AppColors.secondaryText)
                 }
                 
                 Spacer()
                 
                 Button{ dailyViewModel.updateDaily(dailyTask!, context: context) } label: {
                     Text("Done")
                         .foregroundColor(AppColors.primaryText)
                         .padding(10)
                         .background(
                            Capsule()
                                .fill(AppColors.button)
                                .stroke(AppColors.overlayStroke.opacity(0.1), lineWidth: 0.1)
                         )
                 }
              }
        }
    }
    
    @ViewBuilder
    private var forms: some View {
        ScrollView {
            switch mode {
            case .create:
                VStack(spacing:16){
                    TextField("Task title", text: $newTitle)
                        .foregroundColor(AppColors.primaryText)
                        .lineLimit(1)
                        .padding(10)
                        .background(
                            Capsule()
                                .fill(.gray.opacity(0.1))
                                .stroke(AppColors.overlayStroke.opacity(0.15), lineWidth: 0.5)
                        )
                    
                    ZStack(alignment:.topLeading){
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.gray.opacity(0.1))
                            .stroke(AppColors.overlayStroke.opacity(0.15), lineWidth: 0.5)
                        
                        Text("Desription (optional)")
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
                    
                    
                     
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]){
                            ForEach(TaskPriority.allCases, id: \.self){ buttonPriority in
                                PriorityButton(priority: buttonPriority,isSelected: selected == buttonPriority){
                                    selected = buttonPriority
                                }
                                .padding(5)
                            }
                        }
                    
                    
                    
                    
                }
            case .detail:
                VStack(spacing:0){
                    
                }
            case .edit:
                VStack(spacing:0){
                    
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
