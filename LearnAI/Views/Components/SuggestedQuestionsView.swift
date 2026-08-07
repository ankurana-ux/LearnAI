import SwiftUI

struct SuggestedQuestionsView: View {

    let questions: [String]
    let isLoading: Bool
    let onTap: (String) -> Void

    var body: some View {

        VStack(alignment: .leading, spacing: 16) {

            Text("TRY ASKING")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)
                .tracking(1)

            ScrollView(.horizontal, showsIndicators: false) {

                HStack(spacing: 12) {

                    if isLoading {

                        ForEach(0..<4, id: \.self) { _ in

                            RoundedRectangle(cornerRadius: 18)
                                .fill(Color(.secondarySystemBackground))
                                .frame(width: 150, height: 48)

                        }

                    } else {

                        ForEach(questions, id: \.self) { question in

                            Button {

                                onTap(question)

                            } label: {

                                HStack(spacing: 8) {

                                    Image(systemName: "sparkles")
                                        .font(.caption)
                                        .foregroundStyle(.blue)

                                    Text(question)
                                        .font(.subheadline.weight(.medium))
                                        .multilineTextAlignment(.leading)

                                }
                                .padding(.horizontal, 18)
                                .padding(.vertical, 14)
                                .background(Color(.secondarySystemBackground))
                                .clipShape(
                                    RoundedRectangle(cornerRadius: 18)
                                )

                            }
                            .buttonStyle(.plain)

                        }

                    }

                }
                .padding(.vertical, 2)

            }

        }

    }

}

#Preview {

    SuggestedQuestionsView(
        questions: [
            "Is it dangerous?",
            "What does it eat?",
            "Interesting facts"
        ],
        isLoading: false
    ) { _ in }

}
