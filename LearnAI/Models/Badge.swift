import Foundation


enum BadgeRarity: String {

    case bronze
    case silver
    case gold
    case diamond

}

struct Badge: Identifiable {

    let id = UUID()

    let badgeNumber: Int

    let image: String
    let title: String
    let description: String

    let category: String
    let rarity: BadgeRarity

    let currentProgress: Int
    let requiredProgress: Int

    let reward: Int

    let isUnlocked: Bool

}
