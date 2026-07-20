import SwiftUI

struct DetectionCard: View {

    let object: DetectedObject
    let onTap: () -> Void

    var body: some View {

        Button(action: onTap) {

            VStack(alignment: .leading, spacing: 18) {

                // MARK: Header

                HStack(alignment: .top) {

                    HStack(spacing: 10) {

                        Image(systemName: object.icon)
                            .font(.title2)
                            .foregroundStyle(.green)

                        VStack(alignment: .leading, spacing: 2) {

                            Text(object.name)
                                .font(.headline)

                            Text(object.category)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)

                        }

                    }

                    Spacer()

                    confidenceBadge

                }

                // MARK: Summary

                Text(object.shortSummary)
                    .font(.body)
                    .foregroundStyle(.primary)
                    .lineLimit(3)

                // MARK: Quick Facts

                HStack(spacing: 12) {

                    if object.facts.indices.contains(0) {

                        factChip(object.facts[0])

                    }

                    if object.facts.indices.contains(1) {

                        factChip(object.facts[1])

                    }

                }

                Divider()

                // MARK: Footer

                HStack {

                    Spacer()

                    VStack(spacing: 4) {

                        Image(systemName: "chevron.up")
                            .font(.caption.bold())

                        Text("Swipe up")
                            .font(.caption2)

                    }
                    .foregroundStyle(.secondary)

                    Spacer()

                }

            }
            .padding(20)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 28))
            .shadow(radius: 12)

        }
        .buttonStyle(.plain)

    }

    // MARK: Confidence Badge

    private var confidenceBadge: some View {

        Text("\(Int(object.confidence * 100))%")
            .font(.caption.bold())
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(.green.opacity(0.15))
            .foregroundStyle(.green)
            .clipShape(Capsule())

    }

    // MARK: Fact Chip

    @ViewBuilder
    private func factChip(_ fact: ObjectFact) -> some View {

        HStack(spacing: 6) {

            Image(systemName: fact.icon)

            Text(fact.value)

        }
        .font(.caption)
        .padding(.horizontal, 10)
        .padding(.vertical, 8)
        .background(.regularMaterial)
        .clipShape(Capsule())

    }

}

#Preview {

    ZStack {

        Color.black
            .ignoresSafeArea()

        DetectionCard(
            object: MockData.snakePlant,
            onTap: {}
        )
        .padding()

    }

}
