import SwiftUI

struct LearnMoreButton: View {

    let aiInfo: AIObjectInfo?
    let isLoading: Bool
    let action: () -> Void

    var body: some View {

        Button(action: action) {

            Group {

                if isLoading {

                    ProgressView()

                } else {

                    Label(
                        aiInfo == nil
                        ? "Learn More with AI"
                        : "AI Information Loaded",
                        systemImage: aiInfo == nil
                        ? "sparkles"
                        : "checkmark.circle.fill"
                    )

                }

            }
            .frame(maxWidth: .infinity)

        }
        .font(.headline)
        .padding()
        .background(aiInfo == nil ? Color.blue : Color.green)
        .foregroundStyle(.white)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .disabled(isLoading || aiInfo != nil)

    }
}
