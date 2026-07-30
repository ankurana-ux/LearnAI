import Foundation

final class ImageService {

    static let shared = ImageService()

    private init() {}

    func fetchImageURL(
        for topic: String
    ) async throws -> String? {
        
        print("🔍 Searching image for:", topic)

        let encodedTopic = topic.addingPercentEncoding(
            withAllowedCharacters: .urlQueryAllowed
        ) ?? topic

        let urlString =
        "https://commons.wikimedia.org/w/api.php?action=query&generator=search&gsrsearch=\(encodedTopic)&gsrnamespace=6&prop=imageinfo&iiprop=url&format=json"

        guard let url = URL(string: urlString) else {
            return nil
        }

        let (data, _) = try await URLSession.shared.data(
            from: url
        )

        let result = try JSONDecoder().decode(
            WikimediaResponse.self,
            from: data
        )
        print("🖼️ Result URL:", result.query?.pages.values.first?.imageinfo?.first?.url ?? "nil")

        return result.query?.pages.values.first?.imageinfo?.first?.url
    }
 
}

        struct WikimediaResponse: Codable {

            let query: WikimediaQuery?

        }

        struct WikimediaQuery: Codable {

            let pages: [String: WikimediaPage]

        }

        struct WikimediaPage: Codable {

            let imageinfo: [WikimediaImage]?

        }

        struct WikimediaImage: Codable {

            let url: String

        }
