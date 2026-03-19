//
//  PrioritySheets.swift
//  DailyNest
//
//  Created by Atakan on 18.03.2026.
//

import Foundation
import SwiftUI

struct MatrixSettingsSheet: View {
    // Kadranların başlığı
    @AppStorage("quadrantTitle_VeryHigh") private var savedVeryHighTitle: String = "Very High Priority"
    @AppStorage("quadrantTitle_High") private var savedHighTitle: String = "High Priority"
    @AppStorage("quadrantTitle_Medium") private var savedMediumTitle: String = "Medium Priority"
    @AppStorage("quadrantTitle_Low") private var savedLowTitle: String = "Low Priority"

    // Kadran ikonu
    @AppStorage("quadrantIcon_VeryHigh") private var savedVeryHighIcon: String = "🔴"
    @AppStorage("quadrantIcon_High") private var savedHighIcon: String = "🟠"
    @AppStorage("quadrantIcon_Medium") private var savedMediumIcon: String = "🟡"
    @AppStorage("quadrantIcon_Low") private var savedLowIcon: String = "🟢"
    
    @State private var veryHighTitle: String
    @State private var veryHighIcon: String
    
    @State private var highTitle: String
    @State private var highIcon: String
    
    @State private var mediumTitle: String
    @State private var mediumIcon: String
    
    @State private var lowTitle: String
    @State private var lowIcon: String
    
    @Environment(\.dismiss) private var dismiss
    
    init() {
        _veryHighTitle = State(initialValue: UserDefaults.standard.string(forKey: "quadrantTitle_VeryHigh") ?? "Very High Priority")
        _veryHighIcon = State(initialValue: UserDefaults.standard.string(forKey: "quadrantIcon_VeryHigh") ?? "🔴")
        _highTitle = State(initialValue: UserDefaults.standard.string(forKey: "quadrantTitle_High") ?? "High Priority")
        _highIcon = State(initialValue: UserDefaults.standard.string(forKey: "quadrantIcon_High") ?? "🟠")
        _mediumTitle = State(initialValue: UserDefaults.standard.string(forKey: "quadrantTitle_Medium") ?? "Medium Priorty")
        _mediumIcon = State(initialValue: UserDefaults.standard.string(forKey: "quadrantIcon_Medium") ?? "🟡")
        _lowTitle = State(initialValue: UserDefaults.standard.string(forKey: "quadrantTitle_Low") ?? "Low Priority")
        _lowIcon = State(initialValue: UserDefaults.standard.string(forKey: "quadrantIcon_Low") ?? "🟢")
    }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                AppColors.background.ignoresSafeArea()
                VStack(spacing:16) {
                    
                    priorityTextField(
                        title: $veryHighTitle,
                        icon: $veryHighIcon,
                        labelTitle: savedVeryHighTitle
                    )
                    
                    priorityTextField(
                        title: $highTitle,
                        icon: $highIcon,
                        labelTitle: savedHighTitle
                    )
                    
                    priorityTextField(
                        title: $mediumTitle,
                        icon: $mediumIcon,
                        labelTitle: savedMediumTitle
                    )
                    
                    priorityTextField(
                        title: $lowTitle,
                        icon: $lowIcon,
                        labelTitle: savedLowTitle
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
                        savedVeryHighIcon = veryHighIcon
                        savedVeryHighTitle = veryHighTitle
                        savedHighIcon = highIcon
                        savedHighTitle = highTitle
                        savedMediumIcon = mediumIcon
                        savedMediumTitle = mediumTitle
                        savedLowTitle = lowTitle
                        savedLowIcon = lowIcon
                        
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
    }
}
