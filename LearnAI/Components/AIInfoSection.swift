import SwiftUI

struct AIInfoSection: View {

    let ai: AIObjectInfo

    var body: some View {

        VStack(alignment: .leading, spacing: 20) {

            infoCard(
                title: "Summary",
                icon: "text.book.closed.fill",
                content: ai.summary
            )

            infoCard(
                title: "History",
                icon: "clock.arrow.circlepath",
                content: ai.history
            )

            listCard(
                title: "Uses",
                icon: "hammer.fill",
                items: ai.uses
            )

            listCard(
                title: "Fun Facts",
                icon: "sparkles",
                items: ai.funFacts
            )

            infoCard(
                title: "Safety",
                icon: "shield.fill",
                content: ai.safety
            )

        }

    }

    @ViewBuilder
    private func infoCard(
        title: String,
        icon: String,
        content: String
    ) -> some View {

        VStack(alignment: .leading, spacing: 12) {

            Label(title, systemImage: icon)
                .font(.headline)

            Text(content)

        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 14))

    }

    @ViewBuilder
    private func listCard(
        title: String,
        icon: String,
        items: [String]
    ) -> some View {

        VStack(alignment: .leading, spacing: 12) {

            Label(title, systemImage: icon)
                .font(.headline)

            ForEach(items, id: \.self) { item in

                Label(item, systemImage: "checkmark.circle.fill")

            }

        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 14))

    }

}

#Preview {

    AIInfoSection(
        ai: AIObjectInfo(
            name: "Apple",
            summary: "A sweet edible fruit.",
            history: "Cultivated for thousands of years.",
            uses: ["Eat", "Juice"],
            funFacts: ["Over 7,000 varieties"],
            safety: "Wash before eating."
        )
    )

}
