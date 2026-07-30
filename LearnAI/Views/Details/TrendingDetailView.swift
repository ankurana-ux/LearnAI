import SwiftUI


struct TrendingDetailView: View {

    let object: LearningTopic
    

    var body: some View {

        ScrollView {

            VStack(alignment: .leading, spacing: 24) {
                Image(systemName: "photo")                    .resizable()
                    .scaledToFill()
                    .frame(height: 250)
                .frame(height: 250)
                .clipShape(
                    RoundedRectangle(cornerRadius: 20)
                )

                Text(object.name)
                    .font(.largeTitle.bold())

                Text(object.description)
                    .font(.body)
                    .foregroundStyle(.secondary)

                Button("Learn with AI") {

                }
                .buttonStyle(.borderedProminent)

            }
            .padding()

        }
        .navigationTitle(object.name)
        .navigationBarTitleDisplayMode(.inline)

    }

}

#Preview {

    TrendingDetailView(
        object: ExploreData.trendingTopics.first!
    )

}
