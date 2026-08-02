import SwiftUI

struct AvailablePointsCard: View {

    @ObservedObject private var learning = LearningProfileService.shared

    var body: some View {

        let profile = learning.profile

        AppCard {

            VStack(alignment: .leading, spacing: 12) {

                AppSectionHeader(
                    title: "Learning Points",
                    icon: "star.fill",
                    color: .orange
                )

                Text("\(profile.points)")
                    .font(.system(size: 42, weight: .bold))

                Text("Available Learning Points")
                    .foregroundStyle(.secondary)

            }

        }

    }

}

#Preview {

    AvailablePointsCard()

}
