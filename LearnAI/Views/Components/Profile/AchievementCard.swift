import SwiftUI

struct AchievementCard: View {

    var body: some View {

        AppCard {

            VStack(alignment: .leading, spacing: 20) {

                AppSectionHeader(
                    title: "Badge Progress",
                    icon: "rosette",
                    color: .orange
                )

                HStack(alignment: .top) {

                    VStack(alignment: .leading, spacing: 6) {

                        Text("12 / 128")
                            .font(.system(size: 42, weight: .bold))

                        Text("Badges Collected")
                            .foregroundStyle(.secondary)

                    }

                    Spacer()

                    Image("badge_1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 70)

                }

                ProgressView(value: 12.0 / 128.0)
                    .tint(.orange)
                    .scaleEffect(y: 1.8)

                HStack {

                    VStack(alignment: .leading, spacing: 4) {

                        Text("Next Unlock")
                            .font(.caption)
                            .foregroundStyle(.secondary)

                        Text("Curiosity Spark")
                            .font(.headline)

                    }

                    Spacer()

                    Text("2 / 5")
                        .font(.headline)
                        .foregroundStyle(.orange)

                }

            }

        }

    }

}

#Preview {

    AchievementCard()

}
