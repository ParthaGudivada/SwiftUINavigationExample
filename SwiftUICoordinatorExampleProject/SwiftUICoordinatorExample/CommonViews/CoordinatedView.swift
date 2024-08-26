import SwiftUI

struct CoordinatedView: View {
    @State var pushedDepth: Int
    @State var presentedDepth: Int
    
    let coordinatorTypeName: String
    
    let onPushNext: () -> Void
    let onPopLast: () -> Void
    let onPopToRoot: () -> Void
    
    let onPresentNext: () -> Void
    let onDismissTop: () -> Void
    let onDismissToRoot: () -> Void
    
    let onPresentChild: () -> Void
    let onDismissAll: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 16) {
                pushingOptions
                presentingOptions
            }
            
            Button(action: {
                onPresentChild()
            }, label: {
                Text("Present next coordinator")
            })
            
            Button(action: {
                onDismissAll()
            }, label: {
                Text("Dismiss current coordinator")
            })
        }
        .navigationTitle(coordinatorTypeName)
    }
    
    @ViewBuilder
    private var pushingOptions: some View {
        VStack(spacing: 16) {
            Text("PushedDepth = \(pushedDepth)")
            
            Button(action: {
                onPushNext()
            }, label: {
                Text("Push next")
            })
            
            Button(action: {
                onPopLast()
            }, label: {
                Text("Pop last")
            })
            
            Button(action: {
                onPopToRoot()
            }, label: {
                Text("Pop to root")
            })
        }
        .padding(16)
        .background(Color.gray.opacity(0.5))
        .cornerRadius(16)
    }
    
    @ViewBuilder
    private var presentingOptions: some View {
        VStack(spacing: 16) {
            Text("PresentedDepth = \(presentedDepth)")
            
            Button(action: {
                onPresentNext()
            }, label: {
                Text("Present next")
            })
            
            Button(action: {
                onDismissTop()
            }, label: {
                Text("Dismiss top")
            })
            
            Button(action: {
                onDismissToRoot()
            }, label: {
                Text("Dismiss to root")
            })
        }
        .padding(16)
        .background(Color.gray.opacity(0.5))
        .cornerRadius(16)
    }
}
