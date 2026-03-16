//
//  DayCell.swift
//  DailyNest
//
//  Created by Atakan on 14.03.2026.
//

import SwiftUI

enum CellMode{
    case routine
    case regular
    
        // Her mode kendi rengini biliyor
        private var accentColor: Color {
            switch self {
            case .routine: return AppColors.routine
            case .regular: return AppColors.button
            }
        }
        
        func circleColor(isSelected: Bool, isToday: Bool) -> Color {
            if isSelected { return accentColor }
            if isToday    { return Color(.systemBackground) }
            return .clear
        }
        
        func numberColor(isSelected: Bool, isToday: Bool) -> Color {
            if isSelected { return .white }
            if isToday    { return accentColor.opacity(0.75) }
            return Color(.label)
        }
        
        func letterColor(isSelected: Bool) -> Color {
            isSelected ? accentColor : Color(.secondaryLabel)
        }
    
        func dateFormat() -> String {
        switch self {
        case .routine: return "EEEEEEEE"
        case .regular: return "dd"
        }
    }
}

struct DayCell: View {
    
    let date: Date
    let isSelected: Bool
    let isToday: Bool
    let mode: CellMode
    
    private let calendar = Calendar.current
    
    private var dayLetter : String {
        let formatter = DateFormatter()
        formatter.dateFormat = mode.dateFormat()
        return formatter.string(from: date).uppercased()
    }
    
    private var dayNumber: String{
        "\(calendar.component(.day, from: date))"
    }
    
    
    var body: some View {
        
        VStack(spacing: 8){
            
            Text(dayLetter)
                .font(.system(size:13,weight: .medium))
                .foregroundColor(mode.letterColor(isSelected: isSelected))
            
            ZStack{
                Circle()
                    .fill(mode.circleColor(isSelected: isSelected, isToday: isToday))
                    .frame(width: 40,height: 40)
                    .shadow(
                        color: isToday && !isSelected ?
                            .black.opacity(0.1) : .clear,
                        radius: 4, x: 0, y: 2
                    )
                
                Text(dayNumber)
                    .font(.system(size: 17,weight: isSelected || isToday ? .semibold : .regular))
                    .foregroundColor(mode.numberColor(isSelected: isSelected, isToday: isToday))
            }
        }
        .frame(width: 40)
        
    }
}

#Preview {
    DayCell(date: Date(), isSelected: true, isToday: true,mode: .routine)
}
