import SwiftUI

struct SecondTabScreen: View {
    
    @EnvironmentObject var coordinator: SecondTabCoordinator
    
    var body: some View {
        Text("Second tab")
        
        Button(action: {
            coordinator.pushNextScreen()
        }, label: {
            Text("Push next")
        })
    }
}
