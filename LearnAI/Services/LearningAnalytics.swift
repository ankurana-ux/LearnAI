import Foundation

final class LearningAnalytics {

    static let shared = LearningAnalytics()

    private init() {}


    private var events: [LearningEvent] = []


    func track(
        _ event: LearningEvent
    ) {

        events.append(event)

    }


    func hasEnoughData() -> Bool {

        return events.count > 100

    }


    func topTopics() -> [LearningTopic] {

        // Future:
        // calculate ranking from real users

        return []

    }

}


enum LearningEvent {

    case scan(String)
    case search(String)
    case question(String)
    case opened(String)
    case favourite(String)

}
