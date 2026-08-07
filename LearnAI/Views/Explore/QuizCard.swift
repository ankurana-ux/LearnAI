import SwiftUI

struct QuizCard: View {

    @ObservedObject private var learning = LearningProfileService.shared

    var body: some View {

        AppCard {

            VStack(alignment: .leading, spacing: 10) {

                HStack(alignment: .top) {

                    AppSectionHeader(
                        title: "Quiz",
                        icon: "brain.head.profile",
                        color: Color(
                            red: 156 / 255,
                            green: 163 / 255,
                            blue: 175 / 255
                        )
                    )

                    Spacer()

                    Text("+10 LP")
                        .font(.caption.bold())
                        .foregroundStyle(.orange)

                }

                Text("Want to take a quiz?")
                    .font(.title3.bold())

                Text("Whatever you've learned and scanned this week.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)


                HStack {

                    Text("Take Quiz")

                    Image(systemName: "arrow.right")

                }
                .font(.headline)
                .foregroundStyle(.blue)

            }

        }

    }

}

#Preview {

    QuizCard()

}
