import Foundation

final class ExploreAIService {

    static let shared = ExploreAIService()

    private init() {}


    func generateDailyCuriosity(
        history: [ScanHistory]
    ) async throws -> LearningTopic {

        let exploredTopics = history
            .map { $0.name }
            .joined(separator: ", ")

        let prompt = """
        You are the AI teacher inside LearnAI.

        Based on the user's learning history:

        \(exploredTopics)

        Create one interesting Daily Curiosity topic.

        The topic should help the user discover something new.

        Return ONLY valid JSON:

        {
          "name": "",
          "summary": "",
          "description": "",
          "category": ""
        }
        """

        let response = try await AIService.shared.generateExploreContent(
            prompt: prompt
        )


        let data = response.data(using: .utf8)!

        let result = try JSONDecoder().decode(
            DailyCuriosityResponse.self,
            from: data
        )


        return LearningTopic(
            name: result.name,
            imageURL: nil,
            summary: result.summary,
            description: result.description,
            learners: nil,
            category: result.category
        )

    }

}


struct DailyCuriosityResponse: Codable {

    let name: String
    let summary: String
    let description: String
    let category: String

}
