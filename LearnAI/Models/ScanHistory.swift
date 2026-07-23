import Foundation

struct StoredAIInfo: Codable {

    let summary: String
    let history: String
    let uses: [String]
    let funFacts: [String]
    let safety: String

}

struct ScanHistory: Identifiable, Codable {

    let id = UUID()
    let name: String
    let confidence: Double
    let date: Date
    var isFavorite = false
    var imageData: Data?
    var aiInfo: StoredAIInfo?

}
