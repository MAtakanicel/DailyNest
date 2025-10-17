
import SwiftUI

struct NoficationButton: View {
    var body: some View {
        
        Button(action: { }) {
            Image(systemName: "bell")
                .foregroundColor(.blue)
                .font(.system(size: 22))
        }
     
    }
}

#Preview {
    TabBarView()
}
