import SwiftUI

struct DailyMomentumCard: View {

    @ObservedObject private var learning = LearningProfileService.shared

    var body: some View {

        let profile = learning.profile

        VStack(alignment: .leading, spacing: 10) {

            // Header

            HStack(spacing: 8) {

                Image(systemName: "bolt.fill")
                    .foregroundStyle(.yellow)

                Text("DAILY MOMENTUM")
                    .font(.caption.bold())
                    .foregroundStyle(
                        Color(
                            red: 156/255,
                            green: 163/255,
                            blue: 175/255
                        )
                    )

            }

            // Streak

            HStack(alignment: .firstTextBaseline, spacing: 10) {

                Text("\(profile.currentStreak)")
                    .font(.system(size: 54, weight: .bold))

                Text("DAY STREAK")
                    .font(.title3.weight(.semibold))
                    .foregroundStyle(.gray)

            }

            // Description

            Text(
                "Ranking \(profile.rank). You have learned about \(profile.scansThisMonth) items this month. Keep the momentum going."
            )
            .font(.footnote)
            .foregroundStyle(.secondary)

            // Progress

            HStack(spacing: 10) {

                ProgressView(value: max(profile.progressToNextLevel, 0.01))
                    .tint(.white)

                Text("\(Int(profile.progressToNextLevel * 100))% Leaderboard")
                    .font(.caption.bold())
                    .foregroundStyle(.white)

            }

        }
        .foregroundStyle(.white)
        .padding(24)
        .frame(maxWidth: .infinity, alignment: .leading)

        .background(
            Color(
                red: 43/255,
                green: 43/255,
                blue: 43/255
            )
        )
        .clipShape(
            RoundedRectangle(cornerRadius: 28)
        )
        .shadow(
            color: .black.opacity(0.08),
            radius: 12,
            y: 6
        )

    }

}

#Preview {
    DailyMomentumCard()
}
