import Foundation

final class WorldLearningService {

    static let shared = WorldLearningService()

    private init() {}


    func fetchTopics() async throws -> [LearningTopic] {


        if LearningAnalytics.shared.hasEnoughData() {


            let topics = LearningAnalytics.shared.topTopics()


            if !topics.isEmpty {

                return topics

            }

        }


        return try await GeminiLearningProvider()
            .fetchTopics()

    }

}
