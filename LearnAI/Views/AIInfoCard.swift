import SwiftUI

struct AIInfoCard: View {

    let title: String
    let text: String

    var body: some View {

        VStack(alignment: .leading, spacing: 18) {

            Text("AI ANALYSIS")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)
                .tracking(1)

            Text(title)
                .font(.title3.bold())

            Text(text)
                .font(.body)
                .foregroundStyle(.secondary)
                .lineSpacing(6)

        }
        .padding(24)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.secondarySystemBackground))
        .clipShape(
            RoundedRectangle(cornerRadius: 24)
        )

    }

}

#Preview {

    AIInfoCard(
        title: "History",
        text: "This is an example of how the AI information will appear inside the card."
    )

}
