import SwiftUI

@main
struct SwiftUICoordinatorExampleApp: App {
    
    @StateObject var appCoordinator = AppCoordinator()
    
    private var tabBarCoordinator: TabBarCoordinator {
        appCoordinator.tabBarCoordinator
    }
    
    var body: some Scene {
        WindowGroup {
            tabBarCoordinator.rootView
                .onOpenURL { url in
                    print(url.absoluteString)
                    appCoordinator.deeplinkCoordinator.handleURL(url)
                }
        }
    }
}
