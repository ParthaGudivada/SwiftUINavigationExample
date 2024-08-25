import Foundation

protocol Routable: HashableByType {
    var navigationType: NavigationType { get }
}
