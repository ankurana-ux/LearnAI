import SwiftUI

struct CategoryTopicImage: View {

    let topic: LearningTopic

    @StateObject private var imageLoader = RemoteImageLoader()

    var body: some View {

        Group {

            if let urlString = imageLoader.imageURL,
               let url = URL(string: urlString) {

                AsyncImage(url: url) { image in

                    image
                        .resizable()
                        .scaledToFill()

                } placeholder: {

                    ProgressView()

                }

            } else {

                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.secondary)

            }

        }
        .onAppear {

            imageLoader.load(
                topic: topic.name
            )

        }

    }

}
