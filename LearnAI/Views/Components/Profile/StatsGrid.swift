import SwiftUI

struct StatsGrid: View {

    @ObservedObject private var learning = LearningProfileService.shared

    private let columns = [

        GridItem(.flexible()),
        GridItem(.flexible())

    ]

    var body: some View {

        let profile = learning.profile

        LazyVGrid(columns: columns, spacing: 16) {

            StatCard(
                icon: "items_scanned",
                value: "\(profile.totalScans)",
                title: "Scanned"
            )

            StatCard(
                icon: "items_searched",
                value: "0",
                title: "Searched"
            )

            StatCard(
                icon: "quiz_taken",
                value: "\(profile.quizzesCompleted)",
                title: "Quiz Taken"
            )

            StatCard(
                icon: "streak_done",
                value: "\(profile.currentStreak)",
                title: "Streak"
            )

        }

    }

}

#Preview {

    StatsGrid()

}
