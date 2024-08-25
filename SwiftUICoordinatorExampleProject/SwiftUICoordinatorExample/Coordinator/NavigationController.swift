import SwiftUI

final class NavigationController<Route: Routable>: ObservableObject {
    
    @Published var navigationPath = NavigationPath()
    @Published var presentedRoute: Route?
    
    private let onDismissPresented: (NavigationController) -> Void
    
    init(onDismissPresented: @escaping (NavigationController) -> Void) {
        self.onDismissPresented = onDismissPresented
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
            self.onDismissPresented(self)
        }
    }
}
