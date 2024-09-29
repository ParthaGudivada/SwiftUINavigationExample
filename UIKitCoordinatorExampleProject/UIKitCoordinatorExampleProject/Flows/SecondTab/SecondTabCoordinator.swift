import SwiftUI
import UIKit

final class SecondTabCoordinator: FlowCoordinator {
    
    var finishDelegate: (any CoordinatorFinishDelegate)?
    var childCoordinator: Coordinator?
    private let startNavigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        startNavigationController = navigationController
    }

    func start() {
        let vc = UIHostingController(rootView: view)
        startNavigationController.setViewControllers([vc], animated: false)
    }
    
    private var view: some View {
        VStack {
            Text("Second Tab Screen")
        }
    }
    
    deinit {
        print("Deinit SecondTabCoordinator")
    }
}
