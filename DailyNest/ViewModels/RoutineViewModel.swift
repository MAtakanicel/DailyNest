import Foundation
import Combine


@MainActor
final class RoutineViewModel : ObservableObject {
    @Published var routines: [Routine] = []
    
    init(routines: [Routine]) {
    
    }
    
    func loadRoutines() async {
        routines 
    }
}
