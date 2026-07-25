import SwiftUI

struct DailyCuriosityCard: View {

    let object: TrendingObject

    var body: some View {

        VStack(alignment: .leading, spacing: 16) {

            Image(object.imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 180)
                .frame(maxWidth: .infinity)
                .clipShape(
                    RoundedRectangle(cornerRadius: 18)
                )

            Text("✨ DAILY CURIOSITY")
                .font(.caption.weight(.bold))
                .foregroundStyle(.orange)

            Text(object.name)
                .font(.title2.bold())

            Text(object.summary)
                .foregroundStyle(.secondary)

            Label("Learn More", systemImage: "arrow.right.circle.fill")
                .font(.headline)
                .foregroundStyle(.blue)

        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(
            RoundedRectangle(cornerRadius: 24)
        )

    }

}

#Preview {

    DailyCuriosityCard(
        object: ExploreData.trendingObjects.first!
    )

}
