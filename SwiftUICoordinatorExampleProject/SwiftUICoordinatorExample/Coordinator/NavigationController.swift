import SwiftUI

final class NavigationController<Route: Routable>: ObservableObject {
    
    @Published var navigationPath = NavigationPath()
    @Published var presentedRoute: Route?
    
    private let onDismissPresentedNavigationController: (NavigationController) -> Void
    
    init(onDismissPresentedNavigationController: @escaping (NavigationController) -> Void) {
        self.onDismissPresentedNavigationController = onDismissPresentedNavigationController
    }
    
    func isPresenting(with type: PresentationType) -> Binding<Bool> {
        Binding<Bool> { [weak self] in
            guard let currentType = self?.presentedRoute?.navigationType.presentationType else {
                return false
            }
            return currentType == type
        } set: { [weak self] newValue in
            guard let self, !newValue else { return }
            self.presentedRoute = nil
            self.onDismissPresentedNavigationController(self)
        }
    }
}
