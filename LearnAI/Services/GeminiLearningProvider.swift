import Foundation

final class GeminiLearningProvider: LearningTopicProvider {


    func fetchTopics() async throws -> [LearningTopic] {


        let prompt = """
        Create the top things the world is learning today.

        Return ONLY JSON array:

        [
          {
            "name":"",
            "summary":"",
            "description":"",
            "category":"",
            "learners":""
          }
        ]

        Generate 5 topics.
        """


        let response = try await AIService.shared.generateExploreContent(
            prompt: prompt
        )


        let data = response.data(using: .utf8)!


        let result = try JSONDecoder()
            .decode(
                [WorldLearningResponse].self,
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


struct WorldLearningResponse: Codable {

    let name: String
    let summary: String
    let description: String
    let category: String
    let learners: String?

}
