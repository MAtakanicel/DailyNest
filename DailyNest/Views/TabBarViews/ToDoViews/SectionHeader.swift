
import SwiftUI

struct SectionHeader: View {
    let title: String
    @Binding var isExpanded: Bool

    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
                .foregroundColor(AppColors.secondaryText)
            Button {
                withAnimation { isExpanded.toggle() }
            } label: {
                Image(systemName: isExpanded ? "chevron.down" : "chevron.right")
                    .foregroundColor(AppColors.buttonTapped)
            }
            .buttonStyle(BorderlessButtonStyle())
        }
    }
}

#Preview {
    TabBarView()
}
