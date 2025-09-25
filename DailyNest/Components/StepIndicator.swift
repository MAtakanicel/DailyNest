import SwiftUI

enum StepIndicatorStyle {
    case compact
    case labeled
}

struct StepIndicator: View {
    let total: Int
    let currentIndex: Int
    var style: StepIndicatorStyle = .compact
    
    var body: some View {
        HStack(spacing: 6) {
            ForEach(0..<total, id: \.self) { index in
                HStack(spacing: 6) {
                    Circle()
                        .fill(color(for: index))
                        .frame(width: circleSize, height: circleSize)
                    if index < total - 1 {
                        Capsule()
                            .fill(lineColor(for: index))
                            .frame(width: 100, height: lineHeight)
                    }
                }
            }
            Image(systemName: currentIndex < total - 1 ? "chevron.right" : "checkmark")
                .foregroundColor(arrowColor)
                .font(.system(size: arrowSize, weight: .semibold))
        }
    }
    
    private var circleSize: CGFloat { style == .compact ? 6 : 10 }
    private var lineHeight: CGFloat { style == .compact ? 1.5 : 2 }
    private var arrowSize: CGFloat { style == .compact ? 12 : 14 }
    private var arrowColor: Color { currentIndex < total - 1 ? AppColors.accent : AppColors.success }
    
    private func color(for index: Int) -> Color {
        if index < currentIndex { return AppColors.success }
        if index == currentIndex { return AppColors.accent }
        return AppColors.icon
    }
    
    private func lineColor(for index: Int) -> Color {
        if index < currentIndex { return AppColors.success }
        return AppColors.icon.opacity(0.5)
    }
}



