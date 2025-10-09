//
//  NewToDoAddButtonView.swift
//  DailyNest
//
//  Created by Atakan İçel on 8.10.2025.
//

import SwiftUI

struct NewToDoAddButtonView: View {
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button{
                    
                }label: {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .font(.title2)
                        .padding(15)
                        .background(Circle()
                            .fill(
                            LinearGradient(
                                colors: [.blue, .purple],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing)
                            )
                        )
                        .shadow(color: .blue.opacity(0.4), radius: 10, x: 0, y:4)
                        .foregroundColor(.white)
                }
                .alignmentGuide(.bottom){ _ in 0}
            }//HStack
        }//VStack
    }
}

#Preview {
    Group {
        NewToDoAddButtonView()
        TabBarView()
    }

}
