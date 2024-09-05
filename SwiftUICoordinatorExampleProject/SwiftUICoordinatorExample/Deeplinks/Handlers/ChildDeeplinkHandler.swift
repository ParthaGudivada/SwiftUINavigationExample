import UIKit

final class ChildDeeplinkHandler: DeeplinkHandlerProtocol {
    
    private weak var tabBarCoordinator: TabBarCoordinator?
    
    init(
        tabBarCoordinator: TabBarCoordinator
    ) {
        self.tabBarCoordinator = tabBarCoordinator
    }
    
    // MARK: - DeeplinkHandlerProtocol
    
    func canOpenURL(_ url: URL) -> Bool {
        url.absoluteString.hasPrefix("deeplink://child")
    }
    
    func openURL(_ url: URL) {
        guard canOpenURL(url) else {
            return
        }
        tabBarCoordinator?.dismissAll()
        tabBarCoordinator?.activeTab = .firstTab
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.tabBarCoordinator?.firstTabCoordinator.presentChild()
        }
    }
}
