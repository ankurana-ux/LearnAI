import SwiftUI

struct NotificationView: View {

    @Environment(\.dismiss) private var dismiss

    var body: some View {

        NavigationStack {

            ScrollView {

                VStack(spacing: 16) {

                    NotificationCard(
                        icon: "leaf.fill",
                        color: .green,
                        title: "New Discovery",
                        message: "You discovered Snake Plant and earned 25 XP.",
                        time: "2 min ago"
                    )

                    NotificationCard(
                        icon: "brain.head.profile",
                        color: .blue,
                        title: "Daily Quiz",
                        message: "Your daily quiz is ready.",
                        time: "1 hour ago"
                    )

                    NotificationCard(
                        icon: "rosette",
                        color: .orange,
                        title: "Badge Unlocked",
                        message: "Plant Explorer I unlocked.",
                        time: "Yesterday"
                    )

                    NotificationCard(
                        icon: "books.vertical.fill",
                        color: .purple,
                        title: "Collection Progress",
                        message: "Spring Flowers is now 8 / 25 complete.",
                        time: "Yesterday"
                    )

                }
                .padding()

            }
            .navigationTitle("Notifications")
            .navigationBarTitleDisplayMode(.inline)

        }

    }

}

#Preview {

    NotificationView()

}
