import Foundation

struct LearningTopic: Identifiable, Codable {

    let id = UUID()

    let name: String
    var imageURL: String?
    let summary: String
    let description: String

    var learners: String? = nil
    var category: String? = nil

}


