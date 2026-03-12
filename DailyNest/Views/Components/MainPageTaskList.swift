//
//  MainPageTaskList.swift
//  DailyNest
//
//  Created by Atakan on 30.01.2026.
//
import SwiftData
import SwiftUI

struct MainPageTaskList: View {
    let header: String
    let tasks:

    var body: some View {
        LazyVStack(alignment: .leading, spacing: 12) {
            Section(header) {
                ForEach(todaysRoutines) { routine in
                    RoutineRow(routine: routine, mode: .compact)
                        .swipeActions(edge: .trailing) {
                            Button {} label: {
                                Label("Complete", systemImage: "checkmark")
                            }
                            .tint(.green)
                        }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(GradientSectionBackground(viewStyle: .mainPage))
        .padding(.bottom, 10)
    }





    /// Liste Boşsa Çıkacak Görüntü
    private func EmptyStateView() -> some View {
        VStack(spacing: 10) {
            Image(systemName: "checklist")
                .font(.system(size: 40))
                .foregroundColor(.gray.opacity(0.5))
            Text("You’re free today 🎉")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 40)
    }
}
