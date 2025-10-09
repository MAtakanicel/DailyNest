
import Foundation

@MainActor
final class MainPageViewModel : ObservableObject {
    @Published var userName: String = "Atakan" //demo
   
    
    func updateDate() -> String {
        return Date().formatted(.dateTime.weekday(.wide).day().month(.wide))
    }
    
    func getDaytime() -> String {
        let calendar = Calendar(identifier: .gregorian)
        let hour = calendar.component(.hour, from: Date())
        
        if hour >= 0 && hour < 13 {
            return "Günaydın,"
        } else if hour >= 13 && hour < 19 {
            return "Merhabalar,"
        } else {
            return "İyi Akşamlar,"
        }
    }
    
}
