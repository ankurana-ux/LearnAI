import SwiftUI

struct DiscoveryRow: View {

    let title: String
    let image: String?
    let isDiscovered: Bool

    var body: some View {

        AppCard {

            HStack(spacing: 16) {

                Group {

                    if let image {

                        Image(image)
                            .resizable()
                            .scaledToFill()

                    } else {

                        Image(systemName: "questionmark")
                            .font(.title2)

                    }

                }
                .frame(width: 56, height: 56)
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 14))

                VStack(alignment: .leading, spacing: 4) {

                    Text(title)
                        .font(.headline)

                    Text(
                        isDiscovered
                        ? "Discovered"
                        : "Not Discovered"
                    )
                    .font(.caption)
                    .foregroundStyle(
                        isDiscovered
                        ? .green
                        : .secondary
                    )

                }

                Spacer()

                Image(systemName:
                        isDiscovered
                      ? "checkmark.circle.fill"
                      : "lock.fill"
                )
                .foregroundStyle(
                    isDiscovered
                    ? .green
                    : .secondary
                )

            }

        }

    }

}

#Preview {

    VStack(spacing: 16) {

        DiscoveryRow(
            title: "Tulip",
            image: "guess_object",
            isDiscovered: true
        )

        DiscoveryRow(
            title: "Lavender",
            image: nil,
            isDiscovered: false
        )

    }
    .padding()

}
