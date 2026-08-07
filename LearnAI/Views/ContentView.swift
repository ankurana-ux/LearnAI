import SwiftUI

struct ContentView: View {

    @State private var selectedTab: AppTab = .explore
    @StateObject private var router = AppRouter()
    
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
            .environmentObject(router)
            
            if router.destination == nil {

                BottomTabBar(
                    selectedTab: $selectedTab
                )

            }

        }
        .ignoresSafeArea(.keyboard)
        .fullScreenCover(item: $router.destination) { destination in

            switch destination {

            case .quiz:

                QuizView()

            case .guessObject:

                GuessObjectView()

            }

        }
        

    }
        
}

#Preview {

    ContentView()

}
