import SwiftUI

protocol Coordinator: ObservableObject, CoordinatorFinishDelegate {
    
    associatedtype Route: Routable
    associatedtype Content: View
    associatedtype Destination: View
    
    var childCoordinator: (any Coordinator)? { get set }
    
    var finishDelegate: CoordinatorFinishDelegate? { get set }
    
    var navigationControllers: [NavigationController<Route>] { get set }
    
    @ViewBuilder var rootView: Content { get }
    @ViewBuilder func destination(for route: Route) -> Destination
}

extension Coordinator {
    
    func start() {
        navigationControllers.append(
            NavigationController { [weak self] nc in
                self?.dismissNavigationController(nc)
            }
        )
    }
    
    func finish() {
        finishDelegate?.didFinish(childCoordinator: self)
    }
    
    func didFinish(childCoordinator: any Coordinator) {
        self.childCoordinator = nil
    }
    
    func present(child: any Coordinator) {
        self.childCoordinator = child
        child.finishDelegate = self
    }
    
    func push(route: Route) {
        navigationControllers.last?.navigationPath.append(route)
    }
    
    func popLast() {
        guard
            let routesCount = navigationControllers.last?.navigationPath.count,
            routesCount > 0
        else {
            return
        }
        navigationControllers.last?.navigationPath.removeLast()
    }
    
    func popToRoot() {
        guard
            let routesCount = navigationControllers.last?.navigationPath.count,
            routesCount > 0
        else {
            return
        }
        navigationControllers.last?.navigationPath.removeLast(routesCount)
    }
    
    func present(route: Route) {
        navigationControllers.last?.presentedRoute = route
        let nc = NavigationController<Route> { [weak self] nc in
            self?.dismissNavigationController(nc)
        }
        navigationControllers.append(nc)
    }
    
    func dismissTop() {
        guard navigationControllers.count > 1 else { return }
        navigationControllers.removeLast()
        navigationControllers.last?.presentedRoute = nil
    }
    
    func dismissToRoot() {
        childCoordinator?.finish()
        
        guard navigationControllers.count > 1 else { return }
        navigationControllers.removeLast(navigationControllers.count - 1)
        navigationControllers.first?.presentedRoute = nil
    }
    
    func dismissNavigationController(_ nc: NavigationController<Route>) {
        guard let index = navigationControllers.firstIndex(where: { $0 === nc }) else {
            return
        }
        navigationControllers.removeLast(navigationControllers.count - 1 - index)
    }
    
    func isTopNavigationController(_ nc: NavigationController<Route>) -> Bool {
        navigationControllers.last === nc
    }
    
    func shouldPresentChild(from nc: NavigationController<Route>) -> Binding<Bool> {
        Binding<Bool> { [weak self] in
            guard let self else { return false }
            return self.childCoordinator != nil && self.isTopNavigationController(nc)
        } set: { [weak self] newValue in
            guard !newValue else { return }
            self?.childCoordinator = nil
        }
    }
    
    var rootNavigationController: NavigationController<Route> {
        guard let nc = navigationControllers.first else {
            fatalError("Coordinator wasn't started")
        }
        return nc
    }
}

protocol CoordinatorFinishDelegate: AnyObject {
    // TODO: if only one child coorinator - remove parameter
    func didFinish(childCoordinator: any Coordinator)
}
