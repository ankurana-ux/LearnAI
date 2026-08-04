import Foundation

final class BadgeService {

    static let shared = BadgeService()

    let badges: [Badge] = [

        Badge(
            badgeNumber: 1,
            image: "badge_1",
            title: "Curiosity Spark",
            description: "Scan your first real-world object.",
            category: "Discovery",
            rarity: .bronze,
            currentProgress: 2,
            requiredProgress: 5,
            reward: 50,
            isUnlocked: false
        ),

        Badge(
            badgeNumber: 2,
            image: "badge_1",
            title: "Plant Explorer",
            description: "Scan 10 different plants.",
            category: "Nature",
            rarity: .bronze,
            currentProgress: 6,
            requiredProgress: 10,
            reward: 75,
            isUnlocked: false
        ),

        Badge(
            badgeNumber: 3,
            image: "badge_1",
            title: "Kitchen Detective",
            description: "Scan 5 kitchen objects.",
            category: "Everyday",
            rarity: .bronze,
            currentProgress: 5,
            requiredProgress: 5,
            reward: 100,
            isUnlocked: true
        ),

        Badge(
            badgeNumber: 4,
            image: "badge_1",
            title: "Currency Hunter",
            description: "Scan 10 different currencies.",
            category: "Finance",
            rarity: .bronze,
            currentProgress: 3,
            requiredProgress: 10,
            reward: 100,
            isUnlocked: false
        ),

        Badge(
            badgeNumber: 5,
            image: "badge_1",
            title: "Tech Observer",
            description: "Discover everyday technology.",
            category: "Technology",
            rarity: .bronze,
            currentProgress: 4,
            requiredProgress: 8,
            reward: 100,
            isUnlocked: false
        ),

        Badge(
            badgeNumber: 6,
            image: "badge_1",
            title: "Animal Spotter",
            description: "Identify 15 animals.",
            category: "Wildlife",
            rarity: .bronze,
            currentProgress: 11,
            requiredProgress: 15,
            reward: 120,
            isUnlocked: false
        ),

        Badge(
            badgeNumber: 7,
            image: "badge_1",
            title: "History Seeker",
            description: "Scan 20 historical objects.",
            category: "History",
            rarity: .silver,
            currentProgress: 8,
            requiredProgress: 20,
            reward: 150,
            isUnlocked: false
        ),

        Badge(
            badgeNumber: 8,
            image: "badge_1",
            title: "Food Scientist",
            description: "Discover foods from around the world.",
            category: "Food",
            rarity: .silver,
            currentProgress: 12,
            requiredProgress: 20,
            reward: 175,
            isUnlocked: false
        ),

        Badge(
            badgeNumber: 9,
            image: "badge_1",
            title: "Space Explorer",
            description: "Learn about space-related objects.",
            category: "Space",
            rarity: .silver,
            currentProgress: 20,
            requiredProgress: 20,
            reward: 200,
            isUnlocked: true
        ),

        Badge(
            badgeNumber: 10,
            image: "badge_1",
            title: "Museum Master",
            description: "Visit and scan museum exhibits.",
            category: "Culture",
            rarity: .gold,
            currentProgress: 7,
            requiredProgress: 15,
            reward: 300,
            isUnlocked: false
        ),

        Badge(
            badgeNumber: 11,
            image: "badge_1",
            title: "World Traveler",
            description: "Discover famous landmarks.",
            category: "Geography",
            rarity: .gold,
            currentProgress: 10,
            requiredProgress: 25,
            reward: 350,
            isUnlocked: false
        ),

        Badge(
            badgeNumber: 12,
            image: "badge_1",
            title: "Legendary Explorer",
            description: "Complete every discovery challenge.",
            category: "Discovery",
            rarity: .diamond,
            currentProgress: 45,
            requiredProgress: 100,
            reward: 500,
            isUnlocked: false
        )

    ]

}
