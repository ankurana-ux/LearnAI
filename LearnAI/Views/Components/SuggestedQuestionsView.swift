import SwiftUI

struct SuggestedQuestionsView: View {

    let questions: [String]
    let isLoading: Bool
    let onTap: (String) -> Void

    var body: some View {

        VStack(alignment: .leading, spacing: 12) {

            Label("Try asking", systemImage: "sparkles")
                .font(.headline)

            ScrollView(.horizontal, showsIndicators: false) {

                HStack(spacing: 10) {

                    if isLoading {

                        ForEach(0..<4, id: \.self) { _ in
                            Capsule()
                                .fill(.ultraThinMaterial)
                                .frame(width: 120, height: 38)
                        }

                    } else {

                        ForEach(questions, id: \.self) { question in

                            Button {
                                onTap(question)
                            } label: {
                                Text(question)
                                    .font(.subheadline)
                                    .padding(.horizontal, 14)
                                    .padding(.vertical, 10)
                                    .background(.ultraThinMaterial)
                                    .clipShape(Capsule())
                            }
                            .buttonStyle(.plain)

                        }

                    }

                }
                .padding(.vertical, 2)

            } // ← Missing brace

        }

    }

}

#Preview {
    SuggestedQuestionsView(
        questions: [
            "Is it dangerous?",
            "What does it eat?"
        ],
        isLoading: false
    ) { _ in }
}
