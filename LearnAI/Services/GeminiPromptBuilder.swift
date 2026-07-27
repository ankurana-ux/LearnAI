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
}
