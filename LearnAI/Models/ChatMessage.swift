import Foundation

struct ChatMessage: Identifiable {

    let id: UUID
    let isUser: Bool
    var text: String

    init(
        id: UUID = UUID(),
        isUser: Bool,
        text: String
    ) {
        self.id = id
        self.isUser = isUser
        self.text = text
    }

}
