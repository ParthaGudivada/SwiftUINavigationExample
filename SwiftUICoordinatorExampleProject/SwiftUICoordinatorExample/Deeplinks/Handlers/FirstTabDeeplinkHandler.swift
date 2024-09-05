import UIKit

final class FirstTabDeeplinkHandler: DeeplinkHandlerProtocol {
    
    private weak var tabBarCoordinator: TabBarCoordinator?
    
    init(tabBarCoordinator: TabBarCoordinator) {
        self.tabBarCoordinator = tabBarCoordinator
    }
    
    // MARK: - DeeplinkHandlerProtocol
    
    func canOpenURL(_ url: URL) -> Bool {
        url.absoluteString.hasPrefix("deeplink://first_tab")
    }
    
    func openURL(_ url: URL) {
        guard 
            canOpenURL(url),
            let firstTabCoordinator = tabBarCoordinator?.firstTabCoordinator
        else {
            return
        }
        
        firstTabCoordinator.dismissToRoot()
        firstTabCoordinator.popToRoot()
        
        tabBarCoordinator?.activeTab = .firstTab
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            switch url.path {
            case "/push":
                firstTabCoordinator.pushNextScreen()
            case "/present":
                firstTabCoordinator.presentNextScreen()
            default:
                break
            }
        }
    }
}
