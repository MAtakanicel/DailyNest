
import SwiftUI

struct SectionHeader: View {
    let title: String
    var body: some View {
        HStack {
            Text(title)
                .font(.headline).bold()
                .foregroundColor(AppColors.secondaryText)
          /*  Button {
                withAnimation { isExpanded.toggle() }
            } label: {
                Image(systemName: isExpanded ? "chevron.down" : "chevron.right")
                    .foregroundColor(AppColors.buttonTapped)
            }
            .buttonStyle(BorderlessButtonStyle())
           */
        }
    }
}

#Preview {
    TabBarView()
}
