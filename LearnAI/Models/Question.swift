import Foundation

struct Question: Identifiable {

    let id = UUID()

    let title: String

    let image: String?

    let answers: [String]

    let correctAnswer: Int

}
