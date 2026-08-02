import SwiftUI

struct LeaderboardHeader: View {

    var body: some View {

        HStack {

            Image(systemName: "chevron.left")

            Text("Leaderboard")
                .font(.title2.bold())

            Spacer()

        }

    }

}
