import Foundation
import Combine


@MainActor
final class RoutineViewModel : ObservableObject {
    @Published var routines: [Routine] = []
    
    init() async {
        await loadRoutines()
    }
    
    func loadRoutines() async {
        routines = Data.mockRoutines
    }
    
    private func saveRoutines() async {
        //Veritabanı kaydı
    }
    
    func deleteRoutine(at indexSet: IndexSet) async  {
        routines.remove(atOffsets: indexSet)
        await saveRoutines()
    }
    
    
    func addRoutine(_ routine: Routine) async {
        let newRoutine = Routine(
            id: UUID(),
            description: routine.description,
            isReminder: routine.isReminder,
            title: routine.title,
            createdAt: routine.createdAt,
            routineDays: routine.routineDays,
            isCompletedToday: routine.isCompletedToday,
            reminderTime: routine.reminderTime
        )
        
        routines.append(newRoutine)
        await saveRoutines()
        
    }
    
}
