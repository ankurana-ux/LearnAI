import SwiftUI

struct UserRankCard: View {

    @ObservedObject private var learning = LearningProfileService.shared

    var body: some View {

        let profile = learning.profile

        VStack(alignment: .leading, spacing: 20) {

            HStack {

                VStack(alignment: .leading, spacing: 6) {

                    Text("YOUR RANK")
                        .font(.caption.weight(.bold))
                        .foregroundStyle(.white.opacity(0.8))

                    Text("Curiosity Spark")
                        .font(.title2.bold())
                        .foregroundStyle(.white)

                    Text("Level \(profile.level) Explorer")
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.85))

                }

                Spacer()

                Circle()
                    .fill(.white.opacity(0.2))
                    .frame(width: 72, height: 72)
                    .overlay {

                        Image(systemName: "person.fill")
                            .font(.title)
                            .foregroundStyle(.white)

                    }

            }

            Divider()
                .overlay(.white.opacity(0.2))

            HStack {

                VStack(alignment: .leading, spacing: 4) {

                    Text("#206")
                        .font(.title.bold())
                        .foregroundStyle(.white)

                    Text("Global Rank")
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.8))

                }

                Spacer()

                VStack(alignment: .trailing, spacing: 4) {

                    Text("\(profile.points) LP")
                        .font(.title3.bold())
                        .foregroundStyle(.white)

                    Text("Top 12%")
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.8))

                }

            }

        }
        .padding(24)
        .background(
            LinearGradient(
                colors: [
                    Color(red: 124/255, green: 58/255, blue: 237/255),
                    Color(red: 99/255, green: 102/255, blue: 241/255)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(
            RoundedRectangle(cornerRadius: 28)
        )

    }

}

#Preview {

    UserRankCard()

}
