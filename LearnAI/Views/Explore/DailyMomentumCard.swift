import SwiftUI

struct DailyMomentumCard: View {

    @ObservedObject private var learning = LearningProfileService.shared

    var body: some View {

        let profile = learning.profile

        VStack(alignment: .leading, spacing: 20) {

            AppSectionHeader(
                title: "Daily Momentum",
                icon: "bolt.fill",
                color: .yellow
            )

            VStack(alignment: .leading, spacing: 2) {

                Text("\(profile.currentStreak)")
                    .font(.system(size: 42, weight: .bold))

                Text("DAY STREAK")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.secondary)

            }

            Text(
                "Ranking \(profile.rank). You have learned about \(profile.scansThisMonth) items this month. Keep the momentum going."
            )
            .font(.footnote)
            .foregroundStyle(.secondary)

            VStack(spacing: 8) {

                ProgressView(value: max(profile.progressToNextLevel, 0.01))
                    .tint(.white)

                HStack {

                    Spacer()

                    Text("\(Int(profile.progressToNextLevel * 100))% Leaderboard")
                        .font(.caption.bold())

                }

            }

        }
        .foregroundStyle(.white)
        .padding(24)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            LinearGradient(
                colors: [
                    .black,
                    .gray.opacity(0.85)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
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
