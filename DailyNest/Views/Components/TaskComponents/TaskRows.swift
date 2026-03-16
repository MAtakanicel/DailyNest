//
//  TaskRows.swift
//  DailyNest
//
//  Created by Atakan on 30.01.2026.
//

import SwiftUI
import SwiftData

struct RoutineRow: View {
    var routine: RoutineTask
    @Environment(RoutineViewModel.self) private var routineViewModel
    let context : ModelContext
    
    var body: some View {
        HStack {
            ZStack{
                RoundedRectangle(cornerRadius: 6)
                    .stroke(.secondary,lineWidth: 2)
                    .frame(width: 22, height: 22)
                    .foregroundColor(routine.isCompletedToday ? AppColors.progressGreen : .gray.opacity(0.8))
                    .padding(.leading,10)
                
                if routine.isCompletedToday {
                    Image(systemName: "checkmark")
                        .resizable()
                        .foregroundColor(AppColors.progressGreen)
                        .frame(width: 12, height: 12)
                        .padding(.leading,10)
                }
            }
            .onTapGesture {
                if !routine.isCompletedToday{
                    routineViewModel.toggleRoutineCompletion(routine, context: context)
                } else {
                    routineViewModel.routineCompetionResetToday(routine, context: context)
                }
            }
            
            NavigationLink(destination: EmptyView()) {
                Text(routine.title)
                    .foregroundColor(AppColors.cardText)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(12)
                }
            
            Spacer()
            
            Text("\(routineViewModel.todaysRoutineCompletionCount(routine)) / \(routine.maxCount)")
                .font(.subheadline)
                .italic()
                .foregroundStyle(AppColors.secondaryText)
                .padding(.trailing,10)
        }
            .background(routine.isCompletedToday ?
                        ComponentBackgrounds(component: .toDoCellCompleted) :
                            ComponentBackgrounds(component: .toDoCellNotComplited))
            .cornerRadius(16)
            .shadow(color: .gray.opacity(0.25), radius: 2, x: 0, y: 2)
        
    }
}
    struct DailyRow: View {
        var task: DailyTask
        private var isToday : Bool{
            Calendar.current.isDate(task.date, inSameDayAs: Date())
        }
        var body: some View {
            HStack {
                ZStack{
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(.secondary,lineWidth: 2)
                        .frame(width: 20, height: 20)
                        .foregroundColor(task.isCompleted ? AppColors.progressGreen : .gray.opacity(0.8))
                        .padding(.leading,10)
                    
                    if task.isCompleted {
                        Image(systemName: "checkmark")
                            .resizable()
                            .foregroundColor(AppColors.progressGreen)
                            .frame(width: 12, height: 12)
                            .padding(.leading,10)
                    }
                    
                }
                .onTapGesture {
                    task.isCompleted.toggle()
                }
                NavigationLink(destination: EmptyView()) {
                    Text(task.title)
                        .foregroundColor(AppColors.cardText)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical,12)
                        .padding(.leading, 5)
                }
                if isToday {
                    Text("Today")
                        .font(.subheadline)
                        .foregroundColor(AppColors.secondaryText)
                        .padding(.trailing,15)
                    
                }else{
                    Text( task.date, format: .dateTime.day().month())
                        .font(.subheadline)
                        .foregroundColor(AppColors.progressRed)
                        .padding(.trailing,15)
                }
            }
            .background(task.isCompleted ?
                        ComponentBackgrounds(component: .toDoCellCompleted) :
                            ComponentBackgrounds(component: .toDoCellNotComplited))
            .cornerRadius(16)
            .shadow(color: .gray.opacity(0.25), radius: 2, x: 0, y: 2)
        
        }
    }


#Preview {
    TabBar()
        .modelContainer(MockData.previewContainer)
        .environment(HomeViewModel())
        .environment(DailyViewModel())
        .environment(RoutineViewModel())
}
