import SwiftUI

struct WorldLearningSection: View {

    var body: some View {

        VStack(alignment: .leading, spacing: 10) {

            HStack(alignment: .bottom) {

                Text("Trending Around the World")
                    .font(.title3.bold())

                Spacer()

                Text("UPDATED DAILY")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.secondary)

            }

            ScrollView(.horizontal, showsIndicators: false) {

                HStack(spacing: 20) {

                    WorldLearningItem(
                        imageName: "tesla",
                        title: "Roman Empire",
                        subtitle: "Why is everyone suddenly fascinated by Ancient Rome?"
                    )

                    WorldLearningItem(
                        imageName: "tesla",
                        title: "Dinosaurs",
                        subtitle: "What really caused their extinction millions of years ago?"
                    )

                    WorldLearningItem(
                        imageName: "tesla",
                        title: "Cherry Blossoms",
                        subtitle: "Why do cherry blossoms bloom for such a short time?"
                    )

                    WorldLearningItem(
                        imageName: "tesla",
                        title: "Mechanical Watches",
                        subtitle: "How do watches keep perfect time without batteries?"
                    )

                }
                .padding(.horizontal, 2)

            }

        }

    }

}

private struct WorldLearningItem: View {

    let imageName: String
    let title: String
    let subtitle: String

    var body: some View {

        VStack(alignment: .leading, spacing: 0) {

            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 290, height: 210)
                .clipped()

            VStack(alignment: .leading, spacing: 12) {

                Text("TRENDING")
                    .font(.caption.weight(.bold))
                    .foregroundStyle(.secondary)

                Text(title)
                    .font(.title3.bold())

                Text(subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)

            }
            .padding(22)

        }
        .frame(width: 290)
        .background(Color.white)
        .clipShape(
            RoundedRectangle(cornerRadius: 30)
        )
        .shadow(
            color: .black.opacity(0.06),
            radius: 10,
            y: 5
        )

    }

}

#Preview {

    WorldLearningSection()

}
