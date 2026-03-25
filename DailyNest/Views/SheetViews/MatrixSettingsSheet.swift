//
//  PrioritySheets.swift
//  DailyNest
//
//  Created by Atakan on 18.03.2026.
//

import Foundation
import SwiftUI

struct MatrixSettingsSheet: View {
    @State private var veryHighTitle: String
    @State private var veryHighIcon: String
    
    @State private var highTitle: String
    @State private var highIcon: String
    
    @State private var mediumTitle: String
    @State private var mediumIcon: String
    
    @State private var lowTitle: String
    @State private var lowIcon: String
    
    @Environment(\.dismiss) private var dismiss
    @Environment(MatrixSettings.self) private var matrixSettings
    
    init() {
        _veryHighTitle = State(initialValue: UserDefaults.standard.string(forKey: MatrixSettingsKeys.quadrantVeryHighTitle) ?? "Very High")
        _veryHighIcon = State(initialValue: UserDefaults.standard.string(forKey: MatrixSettingsKeys.quadrantVeryHighIcon) ?? "🔴")
        _highTitle = State(initialValue: UserDefaults.standard.string(forKey: MatrixSettingsKeys.quadrantHighTitle) ?? "High")
        _highIcon = State(initialValue: UserDefaults.standard.string(forKey: MatrixSettingsKeys.quadrantHighIcon) ?? "🟠")
        _mediumTitle = State(initialValue: UserDefaults.standard.string(forKey: MatrixSettingsKeys.quadrantMediumTitle) ?? "Medium")
        _mediumIcon = State(initialValue: UserDefaults.standard.string(forKey: MatrixSettingsKeys.quadrantMediumIcon) ?? "🟡")
        _lowTitle = State(initialValue: UserDefaults.standard.string(forKey: MatrixSettingsKeys.quadrantLowTitle) ?? "Low")
        _lowIcon = State(initialValue: UserDefaults.standard.string(forKey: MatrixSettingsKeys.quadrantLowIcon) ?? "🟢")
    }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                AppColors.background.ignoresSafeArea()
                VStack(spacing:16) {
                    
                    priorityTextField(
                        title: $veryHighTitle,
                        icon: $veryHighIcon,
                        labelTitle: matrixSettings.quadrantVeryHighTitle
                    )
                    
                    priorityTextField(
                        title: $highTitle,
                        icon: $highIcon,
                        labelTitle: matrixSettings.quadrantHighTitle
                    )
                    
                    priorityTextField(
                        title: $mediumTitle,
                        icon: $mediumIcon,
                        labelTitle: matrixSettings.quadrantMediumTitle
                    )
                    
                    priorityTextField(
                        title: $lowTitle,
                        icon: $lowIcon,
                        labelTitle: matrixSettings.quadrantLowTitle
                    )
                    
                  
                }
                .padding(20)
                .background(
                    GradientSectionBackground(viewStyle: .mainPage)
                )
                .padding(.horizontal,20)
                .padding(.top,15)
                
              
                
            }
            .navigationTitle("Priority Matrix Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .confirmationAction){
                    Button{
                        matrixSettings.quadrantVeryHighIcon = veryHighIcon
                        matrixSettings.quadrantVeryHighTitle = veryHighTitle
                        matrixSettings.quadrantHighIcon = highIcon
                        matrixSettings.quadrantHighTitle = highTitle
                        matrixSettings.quadrantMediumIcon = mediumIcon
                        matrixSettings.quadrantMediumTitle = mediumTitle
                        matrixSettings.quadrantLowTitle = lowTitle
                        matrixSettings.quadrantLowIcon = lowIcon
                        
                        dismiss()
                    }label:{
                        Image(systemName: "checkmark")
                            .foregroundColor(AppColors.primaryText)
                    }
                }
                
                ToolbarItem(placement: .cancellationAction){
                    Button{ dismiss() } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(AppColors.primaryText)
                    }
                }
            }
        }
    }
    private func priorityTextField(title: Binding<String>, icon: Binding<String>,labelTitle: String) -> some View {
        VStack(alignment: .leading,spacing: 4) {
            Text("\(labelTitle):")
                .foregroundColor(AppColors.primaryText.opacity(0.5))
            
            HStack(spacing:0){
                TextField("",text: icon)
                    .foregroundColor(AppColors.primaryText)
                    .frame(maxWidth: 30)
                    .padding(.horizontal,5)
                    .onChange(of: icon.wrappedValue) { _, newValue in
                        if newValue.count > 1 {
                            icon.wrappedValue = String(newValue.prefix(1))
                        }
                    }
                
                TextField("",text: title)
                    .foregroundColor(AppColors.primaryText)
                    .keyboardType(.asciiCapable)
            }
            .padding(8)
            .background(.gray.opacity(0.1))
            .clipShape(Capsule())
            .overlay(
                Capsule()
                    .stroke(AppColors.overlayStroke.opacity(0.5),lineWidth: 0.1)
            )
        }
    }

}

#Preview {
    NavigationStack{
        MatrixSettingsSheet()
            .environment(MatrixSettings())
    }
}
