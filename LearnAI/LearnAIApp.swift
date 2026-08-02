import SwiftUI
import SwiftData

@main
struct LearnAIApp: App {

    var body: some Scene {

        WindowGroup {
            ContentView()
                .preferredColorScheme(.light)

        }
        .modelContainer(
            for: [
                Item.self,
                SavedObject.self
            ]
        )
    }
}
