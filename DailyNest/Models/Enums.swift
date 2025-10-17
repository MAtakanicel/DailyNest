
import Foundation

enum ToDoPriority: String,Codable,CaseIterable{
    case high, medium, low
}


enum WeekDay: String,Codable,CaseIterable{
    case monday, tuesday, wednesday, thursday, friday, saturday, sunday
}
