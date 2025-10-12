import Foundation

enum WeekDay: String,Codable,CaseIterable{
    case monday, tuesday, wednesday, thursday, friday, saturday, sunday
}

enum ToDoPriority: String,Codable,CaseIterable{
    case high, medium, low
}

struct ToDo : Identifiable, Codable, Equatable, Hashable{
    
    let id : UUID //İD
    var title : String //ADI
    var detail : String? //Notu
    
    var date: Date? // tarih (Ajanda
    var createdAt: Date // Oluşturulma tarihi
    var updateAt: Date? //güncellenme tariih
    
    var isRoutine : Bool // kategorisi
    var routineDays : [WeekDay]? // Haftanın belli günleri alışkanlıkları için
    
    var isCompleted:Bool // tmamlanma
    var completedAt:Date? //Belki
      
    var priority: ToDoPriority? // Bildirim veya hatırlatıcı için

    init(
        id: UUID,
        title: String,
        detail: String? = nil,
        date: Date? = nil,
        createdAt: Date,
        updateAt: Date? = nil
        , isRoutine: Bool,
        routineDays: [WeekDay]? = nil,
        isCompleted: Bool,
        completedAt: Date? = nil,
        priority: ToDoPriority? = nil
    ) {
        self.id = id
        self.title = title
        self.detail = detail
        self.date = date
        self.createdAt = createdAt
        self.updateAt = updateAt
        self.isRoutine = isRoutine
        self.routineDays = routineDays
        self.isCompleted = isCompleted
        self.completedAt = completedAt
        self.priority = priority
    }
}
