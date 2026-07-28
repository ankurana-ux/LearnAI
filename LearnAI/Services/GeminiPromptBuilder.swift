import Foundation

enum GeminiPromptBuilder {

    static let imageRecognition = """
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

    static func objectInformation(for object: String) -> String {
        """
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
    }
    
    static func questionPrompt(
        object: DetectedObject,
        question: String,
        conversation: [ChatMessage]
    ) -> String {

        let history = conversation.map {
            "\($0.isUser ? "User" : "AI"): \($0.text)"
        }
        .joined(separator: "\n")

        return """
        You are an expert educator.

        The user is asking about:

        \(object.name)

        Object summary:
        \(object.shortSummary)

        Previous conversation:

        \(history)

        Latest question:

        \(question)

        Answer naturally.

        Do not repeat previous answers unless necessary.

        Keep the response concise but informative.
        """
    }
}
