import Foundation

class RegisterViewModel: ObservableObject {
    // Step 1
    @Published var firstName: String = ""
    @Published var lastName: String = ""

    // Step 2
    @Published var birthDate: Date = Date()

    // Step 3
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isKVKKAccepted: Bool = false
}
