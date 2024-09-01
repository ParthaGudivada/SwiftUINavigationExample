import SwiftUI

struct CoordinatingView<SomeCoordinator: Coordinator>: View {
    
    @StateObject var nc: NavigationController<SomeCoordinator.Route>
    @StateObject var coordinator: SomeCoordinator
    
    var content: () -> any View
    
    var body: some View {
//        let _ = print(
//            """
//            Update CoordinatingView body for \(SomeCoordinator.self)
//            nc: \(Unmanaged.passUnretained(nc).toOpaque())\n
//            """
//        )
        NavigationStack(path: $nc.navigationPath) {
            AnyView(content())
                .navigationDestination(for: SomeCoordinator.Route.self) {
                    coordinator.destination(for: $0)
                }
        }
        .sheet(isPresented: nc.isPresenting(with: .sheet())) {
            let detents = nc.presentedRoute?.navigationType.presentationType?.detents
            viewToPresent
                .presentationDetents(detents ?? .init())
        }
        .fullScreenCover(isPresented: nc.isPresenting(with: .fullScreenCover)) {
            viewToPresent
        }
        .sheet(isPresented: coordinator.shouldPresentChild(from: nc)) {
            if let childCoordinator = coordinator.childCoordinator {
                AnyView(childCoordinator.rootView)
            }
        }
    }
    
    @ViewBuilder
    private var viewToPresent: some View {
        if
            let route = nc.presentedRoute,
            let nc = coordinator.navigationControllers.last
        {
            CoordinatingView(
                nc: nc,
                coordinator: coordinator
            ) {
                coordinator.destination(for: route)
            }
        }
    }
}
