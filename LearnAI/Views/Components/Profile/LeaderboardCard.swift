import SwiftUI

struct LeaderboardCard: View {

    var body: some View {

        NavigationLink {

            LeaderboardView()

        } label: {

            AppCard {

                HStack {

                    VStack(alignment: .leading, spacing: 8) {

                        AppSectionHeader(
                            title: "Leaderboard",
                            icon: "trophy.fill",
                            color: .orange
                        )

                        Text("Check your ranking")
                            .font(.title3.bold())

                        Text("See how your learning compares with other explorers.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)

                    }

                    Spacer()

                    Image(systemName: "chevron.right")
                        .foregroundStyle(.secondary)

                }

            }

        }
        .buttonStyle(.plain)

    }

}

#Preview {

    LeaderboardCard()

}
