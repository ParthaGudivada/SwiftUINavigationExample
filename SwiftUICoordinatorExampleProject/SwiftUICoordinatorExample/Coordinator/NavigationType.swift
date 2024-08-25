import SwiftUI

enum NavigationType {
    /// A push transition style, commonly used in navigation controllers.
    case push
    /// A presentation style, often used for modal or overlay views.
    case present(PresentationType)
}

enum PresentationType {
    /// A sheet presentation style
    case sheet(Set<PresentationDetent>? = nil)
    /// A full-screen cover presentation style.
    case fullScreenCover
}

extension NavigationType {
    
    var presentationType: PresentationType? {
        guard case .present(let presentationType) = self else {
            return nil
        }
        return presentationType
    }
}

extension PresentationType {
    
    // ignores detents for sheets
    static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
            case (.sheet, .sheet): return true
            case (.fullScreenCover, .fullScreenCover): return true
            default: return false
        }
    }
    
    var detents: Set<PresentationDetent>? {
        guard case .sheet(let detents) = self else {
            return nil
        }
        return detents
    }
}
