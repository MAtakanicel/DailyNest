import Foundation


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
      
    var priority: ToDoPriority? //Sıralama için
    
    var reminderDate: Date?
    var isReminderOn: Bool
    
    init(
        id: UUID,
        title: String,
        detail: String? = nil,
        date: Date? = nil,
        createdAt: Date,
        updateAt: Date? = nil,
         isRoutine: Bool,
        routineDays: [WeekDay]? = nil,
        isCompleted: Bool,
        completedAt: Date? = nil,
        priority: ToDoPriority? = nil,
        reminderDate: Date? = nil,
        isReminderOn: Bool = false
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
        self.reminderDate = reminderDate
        self.isReminderOn = isReminderOn
    }
}
