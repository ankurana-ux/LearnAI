import Foundation

struct AIObjectInfo: Codable {

    let name: String
    let summary: String
    let history: String
    let uses: [String]
    let funFacts: [String]
    let safety: String

}
