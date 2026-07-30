import Foundation

final class TrendingService {

    static let shared = TrendingService()

    private init() {}


    func fetchTrending() async throws -> [LearningTopic] {


        // Future:
        // When real user data exists,
        // this automatically switches to ranking engine.

        if LearningAnalytics.shared.hasEnoughData() {

            let topics = LearningAnalytics.shared.topTopics()

            if !topics.isEmpty {

                return topics

            }

        }


        // Current fallback:
        // Gemini generates trending topics

        let prompt = """
        You are the trending engine for LearnAI.

        Generate the things people are most curious about today.

        Focus on:
        - science
        - technology
        - nature
        - discoveries
        - interesting world events

        Return ONLY valid JSON array:

        [
          {
            "name": "",
            "summary": "",
            "description": "",
            "category": "",
            "learners": ""
          }
        ]

        Generate 5 trending topics.
        """


        let response = try await AIService.shared.generateExploreContent(
            prompt: prompt
        )


        let data = response.data(using: .utf8)!


        let result = try JSONDecoder()
            .decode(
                [TrendingResponse].self,
                from: data
            )


        return result.map {

            LearningTopic(
                name: $0.name,
                imageURL: nil,
                summary: $0.summary,
                description: $0.description,
                learners: $0.learners,
                category: $0.category
            )

        }

    }

}


struct TrendingResponse: Codable {

    let name: String
    let summary: String
    let description: String
    let category: String
    let learners: String?

}
