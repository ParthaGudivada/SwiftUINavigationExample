import Foundation

enum ChildCoordinatorRoute: Routable {
    
    case pushed
    case fullScreenCovered

    var navigationType: NavigationType {
        switch self {
            case .pushed:
                return .push
            case .fullScreenCovered:
                return .present(.fullScreenCover)
        }
    }
}
