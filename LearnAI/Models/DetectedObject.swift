import Foundation

struct ObjectFact: Identifiable {

    let id = UUID()
    let icon: String
    let title: String
    let value: String

}

struct DetectedObject {

    let name: String
    let category: String

    let shortSummary: String
    let detailedSummary: String

    let confidence: Double

    let icon: String

    let facts: [ObjectFact]

}
