import SwiftUI

struct WorldLearningCard: View {

    let object: LearningTopic

    @StateObject private var imageLoader = RemoteImageLoader()

    var body: some View {

        HStack(spacing: 16) {

            if let urlString = imageLoader.imageURL,
               let url = URL(string: urlString) {

                AsyncImage(url: url) { image in

                    image
                        .resizable()
                        .scaledToFill()

                } placeholder: {

                    ProgressView()

                }
                .frame(width: 70, height: 70)
                .clipShape(
                    RoundedRectangle(cornerRadius: 12)
                )

            } else {

                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .frame(width: 70, height: 70)
                    .foregroundStyle(.secondary)

            }


            VStack(alignment: .leading, spacing: 6) {

                Text(object.name)
                    .font(.headline)


                Text(object.learners ?? "")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)


                Text(object.summary)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)

            }

            Spacer()

        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(
            RoundedRectangle(cornerRadius: 18)
        )
        .onAppear {

            imageLoader.load(
                topic: object.name
            )

        }

    }
}


#Preview {

    WorldLearningCard(
        object: WorldLearningData.objects.first!
    )

}
