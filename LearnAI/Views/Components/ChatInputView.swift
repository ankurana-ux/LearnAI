import SwiftUI

struct ChatInputView: View {

    @Binding var question: String
    let isLoading: Bool
    let onSend: () -> Void

    var body: some View {

        VStack(alignment: .leading, spacing: 16) {

            Text("ASK AI")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)
                .tracking(1)

            HStack(spacing: 14) {

                TextField(
                    "Ask anything about this object...",
                    text: $question,
                    axis: .vertical
                )
                .lineLimit(1...4)

                Button(action: onSend) {

                    Image(systemName: "arrow.up")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundStyle(.white)
                        .frame(width: 36, height: 36)
                        .background(
                            question.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || isLoading
                            ? Color.gray.opacity(0.35)
                            : Color.blue
                        )
                        .clipShape(Circle())

                }
                .disabled(
                    question.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || isLoading
                )

            }
            .padding(.horizontal, 18)
            .padding(.vertical, 14)
            .background(Color(.secondarySystemBackground))
            .clipShape(
                RoundedRectangle(cornerRadius: 22)
            )

        }

    }

}

#Preview {

    ChatInputView(
        question: .constant(""),
        isLoading: false,
        onSend: {}
    )

}
