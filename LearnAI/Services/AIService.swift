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

        let prompt = GeminiPromptBuilder.imageRecognition

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

        let prompt = GeminiPromptBuilder.objectInformation(for: object)

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

    func askQuestion(
        about object: String,
        question: String
    ) async throws -> String {

        let prompt = """
        You are an expert teacher.

        The user is asking about: \(object)

        Question:
        \(question)

        Answer in simple, conversational English.

        Keep the answer under 150 words.
        Do not use Markdown.
        """

        return try await generateContent(
            parts: [
                [
                    "text": prompt
                ]
            ]
        )
    }
    
    // MARK: - Gemini API

    private func generateContent(
        parts: [[String: Any]]
    ) async throws -> String {

        let url = URL(
            string: "https://generativelanguage.googleapis.com/v1beta/models/gemini-3.6-flash:generateContent?key=\(apiKey)"
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

        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        guard (200...299).contains(httpResponse.statusCode) else {

            if let error = String(data: data, encoding: .utf8) {
                print("❌ Gemini API Error (\(httpResponse.statusCode))")
                print(error)
            }

            throw NSError(
                domain: "Gemini",
                code: httpResponse.statusCode,
                userInfo: [
                    NSLocalizedDescriptionKey:
                        String(data: data, encoding: .utf8) ?? "Unknown API error"
                ]
            )
        }

        let decoded = try JSONDecoder().decode(
            GenerateContentResponse.self,
            from: data
        )
        
        if let text = decoded.candidates.first?.content.parts.first?.text {
            
        }


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
