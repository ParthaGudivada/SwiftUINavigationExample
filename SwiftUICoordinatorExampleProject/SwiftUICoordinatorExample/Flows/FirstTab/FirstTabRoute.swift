import Foundation

enum FirstTabRoute: Routable {
    
    case pushed
    case sheeted

    var navigationType: NavigationType {
        switch self {
            case .pushed:
                return .push
            case .sheeted:
                return .present(.sheet([.medium, .large]))
        }
    }
}
