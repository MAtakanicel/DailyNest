import Foundation

final class ToDoViewModel : ObservableObject {
    @Published var todos  = MockData.mockData
   
    //Önce rutin, Tamamlanmışlar en altta
    var sortedTodos : [ToDo] {
        todos.sorted { a, b in
            if a.isRoutine != b.isRoutine {
                return a.isRoutine && !b.isRoutine
            }else{
                return !a.isCompleted && b.isCompleted
            }
        }
    }
    //sadece rutin
    var routineTodos : [ToDo] {
        sortedTodos.filter{ $0.isRoutine }
    }
    //sadece rutin olmayan
    var dailyTodos : [ToDo] {
        sortedTodos.filter{ !$0.isRoutine }
    }
    //Sadece aktif rutin olmayan
    var activeDailyTodos : [ToDo] {
        dailyTodos.filter{ !$0.isCompleted }
    }
    //Sadece aktif rutin
    var activeRoutineTodos : [ToDo] {
        routineTodos.filter{ !$0.isCompleted }
    }
    
    //Tüm aktif ToDolar
    var allActiveToDos : [ToDo] {
        sortedTodos.filter{ !$0.isCompleted }
    }
    //Tüm tamamlanmış ToDolar
    var completedTodos : [ToDo] {
        sortedTodos.filter{ $0.isCompleted }
    }
    
    

}


/*

 Sıralama Ölçütü-> Hatırlatıcı (Tarihe yaklaştıkça yukarı) > Öncelik (yüksekten düşüğe) > Rutin > Görev > Tamamlanmış
 
 */
