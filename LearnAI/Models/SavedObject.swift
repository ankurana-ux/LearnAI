import Foundation
import SwiftData

@Model
class SavedObject {

    var name: String
    var category: String
    var summary: String
    var date: Date
    var isFavourite: Bool

    init(
        name: String,
        category: String,
        summary: String
    ) {
        self.name = name
        self.category = category
        self.summary = summary
        self.date = Date()
        self.isFavourite = false
    }
}
