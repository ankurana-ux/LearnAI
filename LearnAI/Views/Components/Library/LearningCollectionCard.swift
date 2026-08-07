import SwiftUI

struct LearningCollectionCard: View {

    let collection: LearningCollection

    var body: some View {

        AppCard {

            VStack(alignment: .leading, spacing: 10) {

                // MARK: Header

                HStack(alignment: .top) {

                    Image(collection.icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 52, height: 52)

                    Spacer()

//                    Text(
//                        "\(Int((Double(collection.discovered) / Double(collection.total)) * 100))%"
//                    )
//                    .font(.headline)
//                    .foregroundStyle(.secondary)

                }

                // MARK: Title

                Text(collection.title)
                    .font(.system(size: 17, weight: .semibold))
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)

                Text(collection.category.uppercased())
                    .font(.caption.bold())
                    .foregroundStyle(
                        Color(
                            red: 156 / 255,
                            green: 163 / 255,
                            blue: 175 / 255
                        )
                    )

                // MARK: Progress

                ProgressView(
                    value: Double(collection.discovered),
                    total: Double(collection.total)
                )
                .tint(.green)

                Text("\(collection.discovered)/\(collection.total) discoveries")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

            }

        }

    }

}

#Preview {

    LearningCollectionCard(
        collection: LearningCollectionService.shared.collections.first!
    )

}
