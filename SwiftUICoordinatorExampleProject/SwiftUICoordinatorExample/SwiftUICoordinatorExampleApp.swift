import SwiftUI

@main
struct SwiftUICoordinatorExampleApp: App {
    
    @StateObject var tabBarCoordinator = TabBarCoordinator()
    
    var body: some Scene {
        WindowGroup {
            tabBarCoordinator.rootView
        }
    }
}
