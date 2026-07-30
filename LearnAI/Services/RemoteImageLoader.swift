import Foundation
import SwiftUI
import Combine

@MainActor
final class RemoteImageLoader: ObservableObject {

    @Published var imageURL: String?

    func load(
        topic: String
    ) {

        Task {

            do {

                let url = try await ImageService.shared.fetchImageURL(
                    for: topic
                )

                imageURL = url

            } catch {

                print("❌ Image loading failed:", error.localizedDescription)

            }

        }

    }

}
