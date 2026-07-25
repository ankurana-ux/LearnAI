import Foundation

struct StoredAIInfo: Codable {

    let summary: String
    let history: String
    let uses: [String]
    let funFacts: [String]
    let safety: String

}

struct ScanHistory: Identifiable, Codable {

    let id: UUID
    init(
        id: UUID = UUID(),
        name: String,
        confidence: Double,
        date: Date,
        isFavorite: Bool = false,
        imageData: Data? = nil,
        aiInfo: StoredAIInfo? = nil
    ) {
        self.id = id
        self.name = name
        self.confidence = confidence
        self.date = date
        self.isFavorite = isFavorite
        self.imageData = imageData
        self.aiInfo = aiInfo
    }
    let name: String
    let confidence: Double
    let date: Date
    var isFavorite = false
    var imageData: Data?
    var aiInfo: StoredAIInfo?

}
