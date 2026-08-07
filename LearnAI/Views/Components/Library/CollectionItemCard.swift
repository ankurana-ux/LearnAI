import SwiftUI

struct CollectionItemCard: View {

    let title: String
    let subtitle: String
    let image: String
    let isDiscovered: Bool

    var body: some View {

        VStack(alignment: .leading, spacing: 0) {

            ZStack {

                Image(image)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 130)
                    .frame(maxWidth: .infinity)
                    .clipped()
                    .grayscale(isDiscovered ? 0 : 1)
                    .opacity(isDiscovered ? 1 : 0.45)

                if !isDiscovered {

                    Image(systemName: "lock.fill")
                        .font(.title2)
                        .foregroundStyle(.white)

                }

            }

            VStack(alignment: .leading, spacing: 6) {

                Text(title)
                    .font(.headline)
                    .lineLimit(2)

                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)

            }
            .padding(12)

        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .shadow(color: .black.opacity(0.06), radius: 8, y: 4)

    }

}

#Preview {

    CollectionItemCard(
        title: "The Secret of Orchid Pollination",
        subtitle: "Recent AI analysis reveals that certain orchids...",
        image: "guess_object",
        isDiscovered: true
    )
    .padding()

}
