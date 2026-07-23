import SwiftUI

struct ContentView: View {

    var body: some View {

        TabView {

            CameraView()
                .tabItem {
                    Label("Scan", systemImage: "camera.viewfinder")
                }

            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }

            LibraryView()
                .tabItem {
                    Label("Library", systemImage: "books.vertical")
                }

            ExploreView()
                .tabItem {
                    Label("Explore", systemImage: "globe")
                }

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }

        }

    }

}

#Preview {
    ContentView()
}
