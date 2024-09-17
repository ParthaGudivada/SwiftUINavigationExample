import SwiftUI
import UIKit

final class SecondTabCoordinator: FlowCoordinator {
    
    var finishDelegate: (any CoordinatorFinishDelegate)?
    var childCoordinator: Coordinator?
    let navigationController = UINavigationController()

    func start() {
        let vc = UIHostingController(rootView: view)
        navigationController.pushViewController(vc, animated: false)
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
