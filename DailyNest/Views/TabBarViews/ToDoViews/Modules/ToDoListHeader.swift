import SwiftUI

struct ToDoListHeader: View {
    var paths: [ToDo] = [ ]
    var body: some View {
        VStack(alignment: .leading){
            Text("\(getDaytime())  Atakan 👋")
                .font(.title.bold())
                .foregroundColor(AppColors.primaryText)
                .padding(.bottom,2)
                .padding(.top,15)
            
            Text(Date().formatted(.dateTime.weekday(.wide).day().month(.wide)))
                .font(.subheadline)
        }
    }
    
    func getDaytime() -> String {
        let calendar = Calendar(identifier: .gregorian)
        let hour = calendar.component(.hour, from: Date())
        
        if hour >= 0 && hour < 12 {
            return "Günaydın,"
        } else if hour >= 12 && hour < 18 {
            return "Merhabalar,"
        } else {
            return "İyi Akşamlar,"
        }
    }
    
}

#Preview {
    TabBarView()
}
