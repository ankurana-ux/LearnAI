import SwiftUI

struct DailyCuriosityCard: View {

    let object: LearningTopic

    @StateObject private var imageLoader = RemoteImageLoader()

    var body: some View {

        VStack(alignment: .leading, spacing: 16) {

            if let urlString = imageLoader.imageURL,
               let url = URL(string: urlString) {

                AsyncImage(url: url) { image in

                    image
                        .resizable()
                        .scaledToFill()

                } placeholder: {

                    ProgressView()

                }
                .frame(height: 180)
                .frame(maxWidth: .infinity)
                .clipShape(
                    RoundedRectangle(cornerRadius: 18)
                )

            } else {

                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.secondary)

            }


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
        .onAppear {

            imageLoader.load(
                topic: object.name
            )

        }

    }

}


#Preview {

    DailyCuriosityCard(
        object: ExploreData.trendingTopics.first!
    )

}
