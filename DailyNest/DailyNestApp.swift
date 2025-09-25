import SwiftUI
import FirebaseCore

@main
struct DailyNestApp: App {
    init() {
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
    }
    var body: some Scene {
        WindowGroup {
            RegisterFlowView()
        }
    }
}
