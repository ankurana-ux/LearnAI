import Foundation

enum Secrets {

    static var geminiAPIKey: String {
        guard
            let url = Bundle.main.url(forResource: "Secrets", withExtension: "plist"),
            let data = try? Data(contentsOf: url),
            let plist = try? PropertyListSerialization.propertyList(
                from: data,
                format: nil
            ) as? [String: Any],
            let apiKey = plist["GEMINI_API_KEY"] as? String
        else {
            fatalError("Missing GEMINI_API_KEY in Secrets.plist")
        }

        return apiKey
    }
}
