import Foundation

final class LearningCollectionService {

    static let shared = LearningCollectionService()

    let collections: [LearningCollection] = [

        LearningCollection(
            title: "Spring Flowers",
            category: "Botany",
            icon: "botany",
            discovered: 12,
            total: 18,
            previewImages: [
                "badge_1",
                "badge_1",
                "badge_1"
            ],
            reward: 250,
            badgeName: "Spring Botanist"
        ),

        LearningCollection(
            title: "Computer Hardware",
            category: "Technology",
            icon: "tech",
            discovered: 8,
            total: 20,
            previewImages: [
                "badge_1",
                "badge_1"
            ],
            reward: 250,
            badgeName: "Computer Genius"
        ),

        LearningCollection(
            title: "Ocean Creatures",
            category: "Marine",
            icon: "marine",
            discovered: 4,
            total: 15,
            previewImages: [
                "badge_1"
            ],
            reward: 250,
            badgeName: "Sea Expert"
        ),
        
        LearningCollection(
            title: "Planet",
            category: "Space",
            icon: "horology",
            discovered: 8,
            total: 20,
            previewImages: [
                "badge_1",
                "badge_1"
            ],
            reward: 250,
            badgeName: "Computer Genius"
        ),

    ]
    
    func register(
        discovery: DiscoveryItem
    ) {

        print("Updating collection: \(discovery.collection)")

    }

}
