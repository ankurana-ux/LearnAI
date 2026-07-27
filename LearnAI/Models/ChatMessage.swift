import Foundation

struct ChatMessage: Identifiable {

    let id = UUID()
    let isUser: Bool
    let text: String

}
