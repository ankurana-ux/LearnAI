import Foundation

final class DiscoveryEngine {

    static let shared = DiscoveryEngine()

    private init() { }

    func registerDiscovery(_ discovery: DiscoveryItem) {

        print("📚 New Discovery")
        print("Name: \(discovery.name)")
        print("Category: \(discovery.category)")
        print("Collection: \(discovery.collection)")

        LearningCollectionService.shared.register(
            discovery: discovery
        )

    }

}
