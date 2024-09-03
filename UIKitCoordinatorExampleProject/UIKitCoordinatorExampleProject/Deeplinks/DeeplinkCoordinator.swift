import Foundation

final class DeeplinkCoordinator {
    
    private var handlers: [DeeplinkHandlerProtocol]
    
    init(handlers: [DeeplinkHandlerProtocol] = []) {
        self.handlers = handlers
    }
    
    func addHandler(_ handler: DeeplinkHandlerProtocol) {
        handlers.append(handler)
    }
    
    @discardableResult
    func handleURL(_ url: URL) -> Bool {
        guard let handler = handlers.first(where: { $0.canOpenURL(url) }) else {
            return false
        }
        handler.openURL(url)
        return true
    }
}
