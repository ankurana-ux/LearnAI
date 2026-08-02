import SwiftUI

struct LeaderboardView: View {

    @State private var selectedFilter = "Weekly"

    var body: some View {

        NavigationStack {

            ScrollView {

                VStack(spacing: 24) {

                    LeaderboardHeader()

                    LeaderboardTabs(
                        selectedFilter: $selectedFilter
                    )

                    UserRankCard()

                    VStack(spacing: 12) {

                        RankingRow(
                            name: "Marcus Thorne",
                            level: "Level 12",
                            xp: "11,200"
                        )

                        RankingRow(
                            name: "Sarah Miller",
                            level: "Level 10",
                            xp: "10,800"
                        )

                        RankingRow(
                            name: "Alex Johnson",
                            level: "Level 9",
                            xp: "9,500"
                        )

                    }

                }
                .padding(.horizontal, 20)
                .padding(.top, 20)

            }
            .navigationTitle("Leaderboard")

        }

    }

}

#Preview {
    LeaderboardView()
}
