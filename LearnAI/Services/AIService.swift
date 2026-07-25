import Foundation
import CoreVideo

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

    // MARK: - Identify from Camera Image

    func identifyObject(
        from pixelBuffer: CVPixelBuffer
    ) async throws -> AIObjectInfo {

        guard let imageData = ImageConverter.jpegData(from: pixelBuffer) else {
            throw NSError(
                domain: "Gemini",
                code: -1,
                userInfo: [
                    NSLocalizedDescriptionKey: "Failed to convert image."
                ]
            )
        }

        let base64Image = imageData.base64EncodedString()

        let prompt = """
        You are an object recognition expert.

        Identify the SINGLE main object in the image.

        Return ONLY valid JSON.

        {
          "name": "",
          "summary": "",
          "history": "",
          "uses": [],
          "funFacts": [],
          "safety": ""
        }

        Rules:
        - Use the common English name.
        - Be specific (e.g. "Labrador Retriever", not "Dog").
        - Do not include markdown.
        - Do not include explanations outside the JSON.
        """

        let text = try await generateContent(
            parts: [
                [
                    "text": prompt
                ],
                [
                    "inline_data": [
                        "mime_type": "image/jpeg",
                        "data": base64Image
                    ]
                ]
            ]
        )

        let cleaned = cleanJSON(text)

        let info = try JSONDecoder().decode(
            AIObjectInfo.self,
            from: Data(cleaned.utf8)
        )

        cache[info.name.lowercased()] = info

        return info
    }

    // MARK: - Fetch by Object Name

    func fetchInfo(
        for object: String
    ) async throws -> AIObjectInfo {

        let key = object
            .lowercased()
            .trimmingCharacters(in: .whitespacesAndNewlines)

        if let cached = cache[key] {
            print("⚡️ Using cached AI response for \(object)")
            return cached
        }

        let prompt = """
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

        let text = try await generateContent(
            parts: [
                [
                    "text": prompt
                ]
            ]
        )

        let cleaned = cleanJSON(text)

        let info = try JSONDecoder().decode(
            AIObjectInfo.self,
            from: Data(cleaned.utf8)
        )

        cache[key] = info

        return info
    }

    // MARK: - Gemini API

    private func generateContent(
        parts: [[String: Any]]
    ) async throws -> String {

        let url = URL(
            string: "https://generativelanguage.googleapis.com/v1beta/models/gemini-3.5-flash:generateContent?key=\(apiKey)"
        )!

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )

        let body: [String: Any] = [
            "contents": [
                [
                    "parts": parts
                ]
            ]
        ]

        request.httpBody = try JSONSerialization.data(
            withJSONObject: body
        )

        let (data, response) = try await URLSession.shared.data(
            for: request
        )

        guard
            let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 200
        else {
            let message = String(
                data: data,
                encoding: .utf8
            ) ?? "Unknown API error"

            throw NSError(
                domain: "Gemini",
                code: -1,
                userInfo: [
                    NSLocalizedDescriptionKey: message
                ]
            )
        }

        let decoded = try JSONDecoder().decode(
            GenerateContentResponse.self,
            from: data
        )

        guard
            let text = decoded
                .candidates
                .first?
                .content
                .parts
                .first?
                .text
        else {
            throw NSError(
                domain: "Gemini",
                code: -1,
                userInfo: [
                    NSLocalizedDescriptionKey: "No response from Gemini."
                ]
            )
        }

        return text
    }

    // MARK: - Helpers

    private func cleanJSON(
        _ text: String
    ) -> String {

        text
            .replacingOccurrences(of: "```json", with: "")
            .replacingOccurrences(of: "```", with: "")
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

// MARK: - Response Models

private struct GenerateContentResponse: Decodable {

    let candidates: [Candidate]

    struct Candidate: Decodable {
        let content: Content
    }

    struct Content: Decodable {
        let parts: [Part]
    }

    struct Part: Decodable {
        let text: String?
    }
}
