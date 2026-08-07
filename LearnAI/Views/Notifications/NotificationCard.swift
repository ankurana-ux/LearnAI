import SwiftUI

struct NotificationCard: View {

    let icon: String
    let color: Color
    let title: String
    let message: String
    let time: String

    var body: some View {

        AppCard {

            HStack(alignment: .top, spacing: 16) {

                Image(systemName: icon)
                    .font(.title2)
                    .foregroundStyle(color)
                    .frame(width: 44)

                VStack(alignment: .leading, spacing: 6) {

                    Text(title)
                        .font(.headline)

                    Text(message)
                        .foregroundStyle(.secondary)

                    Text(time)
                        .font(.caption)
                        .foregroundStyle(.tertiary)

                }

                Spacer()

            }

        }

    }

}

#Preview {

    NotificationCard(
        icon: "leaf.fill",
        color: .green,
        title: "New Discovery",
        message: "You discovered Snake Plant.",
        time: "2 min ago"
    )
    .padding()

}
