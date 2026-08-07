import Foundation

enum AppDestination: Identifiable {

    case quiz
    case guessObject

    var id: String {

        switch self {

        case .quiz:
            return "quiz"

        case .guessObject:
            return "guessObject"

        }

    }

}
