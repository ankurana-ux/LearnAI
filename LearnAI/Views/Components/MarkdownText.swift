import SwiftUI

struct MarkdownText: View {

    let text: String

    var body: some View {
        Text(.init(text))
            .textSelection(.enabled)
    }
}

#Preview {
    MarkdownText(
        text: """
# Penguin

**Bold text**

- Item one
- Item two

This is *italic*.
"""
    )
}
