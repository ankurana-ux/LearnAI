import SwiftUI

struct ContentView: View {

    @State private var selectedTab: AppTab = .explore
    
    var body: some View {

        ZStack(alignment: .bottom) {

            Group {

                switch selectedTab {

                case .explore:
                    ExploreView()

                case .library:
                    LibraryView()

                case .scan:
                    CameraView()

                case .search:
                    SearchView()

                case .profile:
                    ProfileView()

                }

            }

            BottomTabBar(
                selectedTab: $selectedTab
            )

        }
        .ignoresSafeArea(.keyboard)

    }

}

#Preview {

    ContentView()

}
