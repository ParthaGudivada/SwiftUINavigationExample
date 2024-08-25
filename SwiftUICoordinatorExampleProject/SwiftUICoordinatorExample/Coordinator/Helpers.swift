import Foundation

protocol IdentifiableByType: Identifiable {}

extension IdentifiableByType {
    /// The default identifier based on the type name
    var id: String {
        String(describing: self.self)
    }
}

protocol HashableByType: IdentifiableByType, Hashable {}

extension HashableByType {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
