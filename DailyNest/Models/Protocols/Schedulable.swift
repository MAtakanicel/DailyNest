
import Foundation

protocol Schedulable : Identifiable, Codable, Hashable{
    var id: UUID { get }
    var title: String { get  set}
    var description: String? { get  set}
    var isReminder: Bool { get  set}
    var createdAt: Date { get  set}
    
}
