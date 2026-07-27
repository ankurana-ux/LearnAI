import Foundation

struct LearningTopic: Identifiable {

    let id = UUID()

    let name: String
    let imageName: String
    let summary: String
    let description: String

    var learners: String? = nil
    var category: String? = nil

}
