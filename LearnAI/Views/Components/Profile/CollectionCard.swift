import SwiftUI

struct CollectionCard: View {

    let items = [
        "Daffodil",
        "Hibiscus",
        "Sunflower",
        "Lavender"
    ]

    var body: some View {

        AppCard {

            VStack(alignment: .leading, spacing: 18) {

                HStack(alignment: .top, spacing: 18) {

                    Image("badge_1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 72, height: 72)

                    VStack(alignment: .leading, spacing: 6) {

                        Text("Backyard Botany")
                            .font(.headline)

                        Text("Discover common garden plants around you.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)

                    }

                    Spacer()

                }

                ProgressView(value: 0.25)
                    .tint(.green)

                HStack {

                    Text("1 / 4 Collected")
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    Spacer()

                    Text("+250 LP")
                        .font(.caption.bold())
                        .foregroundStyle(.green)

                }

                Divider()

                Text("Items to Discover")
                    .font(.subheadline.bold())

                LazyVGrid(
                    columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ],
                    spacing: 12
                ) {

                    ForEach(items, id: \.self) { item in

                        HStack(spacing: 8) {

                            Image(systemName: "circle")

                            Text(item)
                                .font(.caption)

                            Spacer()

                        }

                    }

                }

            }

        }

    }

}

#Preview {

    CollectionCard()

}
