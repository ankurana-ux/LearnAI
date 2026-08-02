import SwiftUI

struct StatCard: View {

    let icon: String
    let value: String
    let title: String

    var body: some View {

        AppCard {

            HStack(alignment: .center, spacing: 16) {

                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 36, height: 36)

                VStack(alignment: .leading, spacing: 4) {

                    Text(value)
                        .font(.system(size: 28, weight: .bold))

                    Text(title)
                        .font(.system(size: 15, weight: .regular))

                        //.font(.subheadline)
                        .foregroundStyle(.secondary)

                }

                Spacer()

            }
            .frame(height: 60)

        }

    }

}

#Preview {

    StatCard(
        icon: "items_scanned",
        value: "12",
        title: "Items Scanned"
    )

}
