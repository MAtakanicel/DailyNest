
import SwiftUI

struct ProgressCard: View {
    var body: some View {
            HStack{
                ZStack{
                    Circle()
                        .stroke(lineWidth: 8)
                        .foregroundColor(AppColors.accentBlue)
                    
                    Circle()
                        .trim(from: 0, to: 0.625)
                        .stroke(
                            LinearGradient(
                                colors: [AppColors.accentBlue, .purple.opacity(0.8) ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing),
                            style: StrokeStyle(lineWidth: 8, lineCap: .round)
                        )
                        .rotationEffect(.degrees(-90))
                    
                    Text("%62")
                        .font(.headline)
                }
                .frame(width: 70,height: 70)
                .padding(.trailing, 10)
                
                VStack(alignment: .leading, spacing: 4){
                    Text("Bugünün görevleri")
                        .font(.headline)
                        .foregroundColor(AppColors.primaryText)
                    
                    Text("5 / 8 Tamamlandı")
                        .foregroundColor(AppColors.secondaryText)
                        .font(.subheadline)
                }
                Spacer()
            }
            .padding(25)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(.white.opacity(0.5))
                    .shadow(color: .black.opacity(0.2), radius: 6,x: 0, y: 3)
            )
    }
}

#Preview {
    TabBarView()
}
