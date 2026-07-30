import Foundation

final class CategoryService {

    static let shared = CategoryService()

    private init() {}


    func fetchCategoryItems(
        category: String
    ) async throws -> [LearningTopic] {


        let prompt = """
        You are the category learning engine for LearnAI.

        Generate 10 interesting things to learn about:

        Category: \(category)

        Include:
        - living things
        - extinct things
        - famous examples
        - interesting discoveries

        Return ONLY valid JSON array:

        [
          {
            "name": "",
            "summary": "",
            "description": "",
            "category": ""
          }
        ]
        """


        let response = try await AIService.shared.generateExploreContent(
            prompt: prompt
        )


        let data = response.data(using: .utf8)!


        let result = try JSONDecoder()
            .decode(
                [CategoryResponse].self,
                from: data
            )


        return result.map {

            LearningTopic(
                name: $0.name,
                imageURL: nil,
                summary: $0.summary,
                description: $0.description,
                learners: nil,
                category: category
            )

        }

    }

}


struct CategoryResponse: Codable {

    let name: String
    let summary: String
    let description: String

}
