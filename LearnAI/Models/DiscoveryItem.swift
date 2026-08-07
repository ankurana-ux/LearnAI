import Foundation

struct DiscoveryItem: Identifiable {

    let id = UUID()

    let name: String

    let collection: String

    let category: String

    let image: String?

}
