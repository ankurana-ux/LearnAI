import Foundation

struct LearningCollection: Identifiable {

    let id = UUID()

    let title: String
    let category: String

    let icon: String

    var discovered: Int
    let total: Int

    var previewImages: [String]

    let reward: Int
    let badgeName: String

}
