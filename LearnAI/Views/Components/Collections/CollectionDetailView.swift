import SwiftUI

struct CollectionDetailView: View {

    let collection: LearningCollection

    var body: some View {

            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                
                VStack(alignment: .leading, spacing: 10) {

                    HStack {

                        Text(collection.category.uppercased())
                            .font(.caption.bold())
                            .foregroundStyle(.secondary)

                        Spacer()

                        Text("+\(collection.reward) LP")
                            .font(.headline)
                            .foregroundStyle(.orange)

                    }

                    ProgressView(
                        value: Double(collection.discovered),
                        total: Double(collection.total)
                    )
                    .tint(.green)

                    Text("\(collection.discovered)/\(collection.total) discoveries")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                }

                Divider()

                LazyVGrid(
                    columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ],
                    spacing: 20
                ) {

                    NavigationLink {

                        ObjectInfoSheet(
                            object: DetectedObject(
                                name: "Orchid",
                                category: "Botany",
                                shortSummary: "A beautiful flowering plant.",
                                detailedSummary: "Orchids are one of the largest flowering plant families.",
                                confidence: 1,
                                icon: "leaf.fill",
                                facts: [
                                    ObjectFact(
                                        icon: "leaf.fill",
                                        title: "Family",
                                        value: "Orchidaceae"
                                    )
                                ]
                            ),
                            aiInfo: nil,
                            imageData: nil,
                            isLoading: false,
                            onLearnMore: { }
                        )

                    } label: {

                        CollectionItemCard(
                            title: "The Secret of Orchid Pollination",
                            subtitle: "Recent AI analysis reveals that certain orchids...",
                            image: "guess_object",
                            isDiscovered: true
                        )

                    }
                    .buttonStyle(.plain)

                    CollectionItemCard(
                        title: "The Secret of Orchid Pollination",
                        subtitle: "Recent AI analysis reveals that certain orchids...",
                        image: "guess_object",
                        isDiscovered: false
                    )

                    CollectionItemCard(
                        title: "The Secret of Orchid Pollination",
                        subtitle: "Recent AI analysis reveals that certain orchids...",
                        image: "guess_object",
                        isDiscovered: false
                    )

                    CollectionItemCard(
                        title: "The Secret of Orchid Pollination",
                        subtitle: "Recent AI analysis reveals that certain orchids...",
                        image: "guess_object",
                        isDiscovered: false
                    )

                }

            }
            .padding(24)}
            .navigationTitle(collection.title)
            .navigationBarTitleDisplayMode(.inline)

        

    }

}

#Preview {

    CollectionDetailView(
        collection: LearningCollectionService.shared.collections.first!
    )

}
