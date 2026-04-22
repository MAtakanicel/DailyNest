//
//  TaskRows.swift
//  DailyNest
//
//  Created by Atakan on 30.01.2026.
//

import SwiftData
import SwiftUI

enum DailyRowStyle {
    case standart, matrix
}

struct RoutineRow: View {
    var routine: Routine
    @Environment(RoutineViewModel.self) private var routineViewModel
    var onTap: ((Routine) -> Void)? = nil

    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .stroke(.secondary, lineWidth: 2)
                    .frame(width: 22, height: 22)
                    .foregroundColor(routine.isCompletedToday ? AppColors.progressGreen : .gray.opacity(0.8))
                    .padding(.leading, 10)

                if routine.isCompletedToday {
                    Image(systemName: "checkmark")
                        .resizable()
                        .foregroundColor(AppColors.progressGreen)
                        .frame(width: 12, height: 12)
                        .padding(.leading, 10)
                }
            }
            .onTapGesture {
                if !routine.isCompletedToday {
                    routineViewModel.toggleRoutineCompletion(routine)
                } else {
                    routineViewModel.routineCompetionResetToday(routine)
                }
            }

            Button { onTap?(routine) } label: {
                Text(routine.title)
                    .foregroundColor(AppColors.cardText)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(12)
            }

            Spacer()

            Text("\(routineViewModel.todaysRoutineCompletionCount(routine)) / \(routine.routineGoal.targetCount)")
                .font(.subheadline)
                .italic()
                .foregroundStyle(AppColors.secondaryText)
                .padding(.trailing, 10)
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
    var rowStyle: DailyRowStyle = .standart
    var onTap: ((DailyTask) -> Void)? = nil

    @Environment(DailyViewModel.self) private var dailyViewModel
    private var isToday: Bool {
        Calendar.current.isDate(task.date, inSameDayAs: Date())
    }

    var body: some View {
        switch rowStyle {
        case .matrix:
            HStack(spacing: 2) {
                ZStack {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(.secondary, lineWidth: 2)
                        .frame(width: 16, height: 16)
                        .foregroundColor(task.isCompleted ? AppColors.progressGreen : .gray.opacity(0.8))

                    if task.isCompleted {
                        Image(systemName: "checkmark")
                            .resizable()
                            .foregroundColor(AppColors.progressGreen)
                            .frame(width: 10, height: 10)
                    }
                }
                .padding(.trailing, 2)
                .onTapGesture {
                    dailyViewModel.toggleDailyCompletion(task)
                }

                Button { onTap?(task) } label: {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(task.title)
                            .foregroundColor(AppColors.cardText)
                            .font(.footnote)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.vertical, 5)
                            .padding(.leading, 5)

                        if isToday {
                            Text("Today")
                                .font(.caption)
                                .foregroundColor(AppColors.secondaryText)
                                .padding(.leading, 5)

                        } else {
                            Text(task.date, format: .dateTime.day().month())
                                .font(.caption)
                                .foregroundColor(AppColors.progressRed)
                                .padding(.leading, 5)
                        }
                    }
                }
            }
            .opacity(task.isCompleted ? 0.35 : 1)

        case .standart:
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(.secondary, lineWidth: 2)
                        .frame(width: 20, height: 20)
                        .foregroundColor(task.isCompleted ? AppColors.progressGreen : .gray.opacity(0.8))
                        .padding(.leading, 10)

                    if task.isCompleted {
                        Image(systemName: "checkmark")
                            .resizable()
                            .foregroundColor(AppColors.progressGreen)
                            .frame(width: 12, height: 12)
                            .padding(.leading, 10)
                    }
                }
                .onTapGesture {
                    dailyViewModel.toggleDailyCompletion(task)
                }

                Button { onTap?(task) } label: {
                    Text(task.title)
                        .foregroundColor(AppColors.cardText)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 12)
                        .padding(.leading, 5)
                }
                if isToday {
                    Text("Today")
                        .font(.subheadline)
                        .foregroundColor(AppColors.secondaryText)
                        .padding(.trailing, 15)

                } else {
                    Text(task.date, format: .dateTime.day().month())
                        .font(.subheadline)
                        .foregroundColor(AppColors.progressRed)
                        .padding(.trailing, 15)
                }
            }
            .background(task.isCompleted ?
                ComponentBackgrounds(component: .toDoCellCompleted) :
                ComponentBackgrounds(component: .toDoCellNotComplited))
            .cornerRadius(16)
            .shadow(color: .gray.opacity(0.25), radius: 2, x: 0, y: 2)
        }
    }
}

#Preview {
    TabBar(selectedTab: .agendaView)
        .environment(ProgressCardViewModel())
        .environment(MockData.previewDailyViewModel)
        .environment(MockData.previewRoutineViewModel)
        .environment(SheetRouter())
        .environment(CalendarHelper())
}
