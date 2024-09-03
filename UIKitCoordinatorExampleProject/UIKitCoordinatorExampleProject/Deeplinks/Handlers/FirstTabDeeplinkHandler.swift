import UIKit

final class FirstTabDeeplinkHandler: DeeplinkHandlerProtocol {
    
    private weak var tabBarConroller: UITabBarController?
    private weak var firstTabCoordinator: FirstTabCoordinator?
    
    init(
        tabBarConroller: UITabBarController,
        firstTabCoordinator: FirstTabCoordinator
    ) {
        self.tabBarConroller = tabBarConroller
        self.firstTabCoordinator = firstTabCoordinator
    }
    
    // MARK: - DeeplinkHandlerProtocol
    
    func canOpenURL(_ url: URL) -> Bool {
        url.absoluteString.hasPrefix("deeplink://first_tab")
    }
    
    func openURL(_ url: URL) {
        guard canOpenURL(url) else {
            return
        }
        
        firstTabCoordinator?.dismissToRoot(animated: true)
        firstTabCoordinator?.popToRoot(animated: false)
        
        tabBarConroller?.selectedIndex = 0
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            switch url.path {
            case "/push":
                self.firstTabCoordinator?.pushNext()
            case "/present":
                self.firstTabCoordinator?.presentNext()
            default:
                break
            }
        }
    }
}
