import SwiftUI

struct QuickSummaryView: View {

    let object: DetectedObject

    var body: some View {

        VStack(alignment: .leading, spacing: 18) {

            Text("SUMMARY")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)
                .tracking(1)

            Text("Quick Summary")
                .font(.title3.bold())

            Text(object.detailedSummary)
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

    QuickSummaryView(
        object: DetectedObject(
            name: "Orchid",
            category: "Botany",
            shortSummary: "Beautiful flowering plant",
            detailedSummary: "Orchids are one of the largest flowering plant families and are found across the world.",
            confidence: 1,
            icon: "leaf.fill",
            facts: []
        )
    )

}
