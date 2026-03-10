//
//  SwiftUIView.swift
//  DailyNest
//
//  Created by Atakan on 17.02.2026.
//

import SwiftUI
import SwiftData

struct NewTaskButton: View {
    var onTap: () -> Void
    var body: some View {
        
        Button(action: { onTap() }) {
            Image(systemName: "plus")
                .foregroundColor(AppColors.primaryText)
                .font(.system(size: 25))
                .padding(12)
                .background(
                    LinearGradient(colors: [.purple.opacity(0.2),.mint.opacity(0.15)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                                  )
                            .shadow(
                                color: .black.opacity(0.1),
                                radius: 3,
                                x: 0,
                                y: 2
                            )
                            .cornerRadius(50)
                )
        }

    }
}

#Preview {
    TabBar(homeViewModel: HomeViewModel())
        .modelContainer(MockData.previewContainer)
}
