import SwiftUI

struct RecommendedCollectionCard: View {

    var body: some View {

        AppCard {

            VStack(alignment: .leading, spacing: 20) {

                AppSectionHeader(
                    title: "Recommended Collection",
                    icon: "sparkles",
                    color: .green
                )

                HStack(spacing: 20) {

                    Image("botany")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 72, height: 72)

                    VStack(alignment: .leading, spacing: 8) {

                        Text("Backyard Botany")
                            .font(.headline)

                        Text("You're only 2 discoveries away from completing this collection.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)

                        ProgressView(value: 3, total: 5)
                            .tint(.green)

                        Text("3 / 5 Collected")
                            .font(.caption)
                            .foregroundStyle(.secondary)

                    }

                    Spacer()

                }

            }

        }

    }

}

#Preview {
    RecommendedCollectionCard()
}
