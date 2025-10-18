
import Foundation

enum ToDoPriority: String,Codable,CaseIterable{
    case high, medium, low
}


enum WeekDay: String,Codable,CaseIterable{
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
}
