//
//  GreetingModule.swift
//  DailyNest
//
//  Created by Atakan on 30.01.2026.
//
import SwiftUI

struct GreetingsModule: View {
    let greeting: String
    let userName: String
    let dateString: String
    var body: some View {
        
        VStack(alignment: .leading){
            Text("\(greeting)  \(userName) 👋")
                .font(.title2.bold())
                .foregroundColor(AppColors.primaryText)
                .padding(.bottom,2)
                .padding(.top,15)
            
            Text(dateString)
                .font(.subheadline)
                .padding(.bottom,1)
        }
    }
    

    
}

#Preview {
    TabBar()
}
