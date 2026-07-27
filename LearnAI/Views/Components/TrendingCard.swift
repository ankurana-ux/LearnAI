import SwiftUI

struct TrendingCard: View {

    let object: LearningTopic
    
    var body: some View {

        VStack(alignment: .leading, spacing: 12) {

            Image(object.imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 150)
                .frame(maxWidth: .infinity)
                .clipShape(
                    RoundedRectangle(cornerRadius: 16)
                )
                .overlay(alignment: .bottomLeading) {

                    LinearGradient(
                        colors: [.clear, .black.opacity(0.7)],
                        startPoint: .center,
                        endPoint: .bottom
                    )
                    .clipShape(
                        RoundedRectangle(cornerRadius: 16)
                    )

                }

            VStack(alignment: .leading, spacing: 6) {

                Text("TRENDING")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.blue)

                Text(object.name)
                    .font(.title3.bold())

            }

            Text(object.summary)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .lineLimit(3)

        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }

}

#Preview {

    TrendingCard(
        object: ExploreData.trendingTopics.first!
    )

}
