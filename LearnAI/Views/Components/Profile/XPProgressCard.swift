import SwiftUI

struct XPProgressCard: View {

    @ObservedObject private var learning = LearningProfileService.shared

    var body: some View {

        let profile = learning.profile

        VStack(alignment: .leading, spacing: 18) {

            AppSectionHeader(
                title: "Level Progress",
                icon: "chart.line.uptrend.xyaxis",
                color: .orange
            )

            HStack(alignment: .bottom) {

                Text("\(profile.points)")
                    .font(.system(size: 42, weight: .bold))

                Text("/ \(profile.level * 100) LP")
                    .font(.title3)
                    .foregroundStyle(.secondary)
                    .padding(.bottom, 6)

                Spacer()

            }

            ProgressView(value: profile.progressToNextLevel)
                .tint(.orange)
                .scaleEffect(y: 1.8)

            HStack {

                Text("Level \(profile.level)")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Spacer()

                Text("\(Int(profile.progressToNextLevel * 100))% to Level \(profile.level + 1)")
                    .font(.caption.bold())

            }

        }

    }

}

#Preview {

    XPProgressCard()

}
