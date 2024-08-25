import SwiftUI

struct TabBarView: View {
    
    @ObservedObject var coordinator: TabBarCoordinator

    var body: some View {
        let _ = print("Update TabBarView body for TabBarCoordinator \n")

        TabView(selection: $coordinator.activeTab) {
            coordinator.firstTabView
                .tabItem {
                    Label("First", systemImage: "cross")
                }
            
            coordinator.secondTabView
                .tabItem {
                    Label("Second", systemImage: "folder")
                }
        }
    }
}
