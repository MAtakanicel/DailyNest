//
//  ProgressCard.swift
//  DailyNest
//
//  Created by Atakan on 30.01.2026.
//

import SwiftUI

enum ProgressDataType {
    case allTasks
    case routineTasks
    case dailyTasks
}

struct ProgressCardConfig {
    let title: String
    let progressPercentage: String
    let progress: CGFloat
    let progressText: String
    let progressColor: [Color]
}

struct ProgressCard: View {
    let config: ProgressCardConfig
    @State private var animatedProgress: CGFloat = 0

    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .stroke(lineWidth: 8)
                    .foregroundColor(Color(.systemGray5))

                Circle()
                    .trim(from: 0, to: animatedProgress)
                    .stroke(
                        LinearGradient(
                            colors: config.progressColor,
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        style: StrokeStyle(lineWidth: 8, lineCap: .round)
                    )
                    .rotationEffect(.degrees(-90))

                Text(config.progressPercentage)
                    .font(.headline.bold())
                    .contentTransition(.numericText())
                    .animation(.spring(response: 0.5, dampingFraction: 0.8), value: animatedProgress)
            }
            .frame(width: 70, height: 70)
            .padding(.trailing, 10)
            .onAppear {
                withAnimation(.spring(response: 0.9, dampingFraction: 0.75).delay(0.15)) {
                    animatedProgress = config.progress
                }
            }
            .onChange(of: config.progress) { _, newValue in
                withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                    animatedProgress = newValue
                }
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(config.title)
                    .font(.headline)
                    .foregroundColor(AppColors.primaryText)

                Text(config.progressText)
                    .foregroundColor(AppColors.secondaryText)
                    .font(.subheadline)
            }

            Spacer()
        }
        .padding(25)
        .background(ComponentBackgrounds(component: .progressCard))
    }
}


