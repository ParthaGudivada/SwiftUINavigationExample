import Foundation

enum SecondTabRoute: Routable {
    
    case pushed

    var navigationType: NavigationType {
        .push
    }
}
