import SwiftUI

struct LibraryRow: View {

    let item: ScanHistory
    let isExpanded: Bool

    let onTap: () -> Void
    let onFavorite: () -> Void
    let onLearnMore: () -> Void

    @ObservedObject private var history = HistoryService.shared

    var body: some View {

        VStack(alignment: .leading, spacing: 16) {

            // MARK: Header

            HStack(alignment: .center, spacing: 14) {
                
                thumbnail

                VStack(alignment: .leading, spacing: 6) {

                    Text(item.name)
                        .font(.headline)

                    Text(item.date.formatted(date: .abbreviated, time: .shortened))
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    Label(
                        "\(Int(item.confidence * 100))% Confidence",
                        systemImage: "checkmark.seal.fill"
                    )
                    .font(.caption2)
                    .foregroundStyle(.green)

                }

                Spacer()

                VStack {

                    Spacer()

                    HStack(spacing: 16) {

                        Button(action: onFavorite) {

                            Image(systemName: item.isFavorite ? "star.fill" : "star")
                                .font(.title3)
                                .foregroundStyle(.yellow)

                        }
                        .buttonStyle(.plain)

                        Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                            .foregroundStyle(.secondary)

                    }

                    Spacer()

                }
                .frame(width: 60)
                .padding(.trailing, 8)

            }
            .contentShape(Rectangle())
            .onTapGesture(perform: onTap)

            if isExpanded {

                Divider()

                if let stored = item.aiInfo {

                    AIInfoSection(
                        ai: AIObjectInfo(
                            name: item.name,
                            summary: stored.summary,
                            history: stored.history,
                            uses: stored.uses,
                            funFacts: stored.funFacts,
                            safety: stored.safety
                        )
                    )

                } else {

                    VStack(alignment: .leading, spacing: 12) {

                        Text("No AI information available yet.")
                            .foregroundStyle(.secondary)

                        Button(action: onLearnMore) {

                            Label("Learn More with AI", systemImage: "sparkles")

                        }
                        .buttonStyle(.borderedProminent)

                    }

                }

            }

        }
        .padding(.vertical, 8)

    }

    @ViewBuilder
    private var thumbnail: some View {

        if
            let data = item.imageData,
            let image = UIImage(data: data)
        {

            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(width: 70, height: 70)
                .clipShape(RoundedRectangle(cornerRadius: 12))

        } else {

            RoundedRectangle(cornerRadius: 12)
                .fill(.gray.opacity(0.2))
                .frame(width: 70, height: 70)
                .overlay {

                    Image(systemName: "photo")

                }

        }

    }

}

#Preview {

    LibraryRow(
        item: ScanHistory(
            name: "Apple",
            confidence: 0.98,
            date: .now,
            isFavorite: true,
            imageData: nil,
            aiInfo: nil
        ),
        isExpanded: false,
        onTap: {},
        onFavorite: {},
        onLearnMore: {}
    )

}
