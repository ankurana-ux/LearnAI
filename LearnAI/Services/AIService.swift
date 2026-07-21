import Foundation

final class AIService {

    static let shared = AIService()
    private var cache: [String: AIObjectInfo] = [:]

    private init() {}

    private var apiKey: String {
        guard
            let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
            let plist = NSDictionary(contentsOfFile: path),
            let key = plist["GEMINI_API_KEY"] as? String
        else {
            fatalError("GEMINI_API_KEY not found")
        }

        return key
    }

    
    
    func fetchInfo(for object: String) async throws -> AIObjectInfo {
        let key = object.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

        if let cached = cache[key] {
            print("⚡️ Using cached AI response for \(object)")
            return cached
        }
        let url = URL(
            string: "https://generativelanguage.googleapis.com/v1beta/models/gemini-3.5-flash:generateContent?key=\(apiKey)"
        )!

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "contents": [
                [
                    "parts": [
                        [
                            "text": """
                            Return ONLY valid JSON.

                            {
                              "name": "",
                              "summary": "",
                              "history": "",
                              "uses": [],
                              "funFacts": [],
                              "safety": ""
                            }

                            Object: \(object)
                            """
                        ]
                    ]
                ]
            ]
        ]

        request.httpBody = try JSONSerialization.data(withJSONObject: body)

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let http = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        // Only print full response if something went wrong.
        guard http.statusCode == 200 else {

            print("❌ Gemini Error (\(http.statusCode))")
            print(String(data: data, encoding: .utf8) ?? "No response body")

            throw NSError(
                domain: "Gemini",
                code: http.statusCode,
                userInfo: [
                    NSLocalizedDescriptionKey:
                        "Gemini returned HTTP \(http.statusCode)"
                ]
            )
        }

        let gemini = try JSONDecoder().decode(GeminiResponse.self, from: data)

        guard
            let jsonString = gemini.candidates.first?.content.parts.first?.text
        else {
            throw NSError(
                domain: "Gemini",
                code: -1,
                userInfo: [
                    NSLocalizedDescriptionKey:
                        "Gemini returned an empty response."
                ]
            )
        }

        let cleanJSON = jsonString
            .replacingOccurrences(of: "```json", with: "")
            .replacingOccurrences(of: "```", with: "")
            .trimmingCharacters(in: .whitespacesAndNewlines)

        let info = try JSONDecoder().decode(
            AIObjectInfo.self,
            from: Data(cleanJSON.utf8)
        )

        cache[key] = info

        print("💾 Cached AI response for \(object)")

        return info
    }
}
