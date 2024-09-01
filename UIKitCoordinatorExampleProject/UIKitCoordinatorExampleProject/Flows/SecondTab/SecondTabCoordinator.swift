import SwiftUI
import UIKit

final class SecondTabCoordinator: Coordinator {
    
    var finishDelegate: (any CoordinatorFinishDelegate)?
    var childCoordinators: [any Coordinator] = []
    let navigationController = UINavigationController()
    
    init(){}

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
