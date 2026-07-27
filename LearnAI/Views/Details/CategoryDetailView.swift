import SwiftUI

struct CategoryDetailView: View {

    let category: ExploreCategory

    var items: [CategoryItem] {
        CategoryItemData.items.filter {
            $0.category == category.title
        }
    }

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {

        Group {

            if items.isEmpty {

                ContentUnavailableView(
                    "Coming Soon",
                    systemImage: "sparkles",
                    description: Text("We're adding more topics to this category.")
                )

            } else {

                ScrollView {

                    LazyVGrid(columns: columns, spacing: 20) {

                        ForEach(items) { item in

                            NavigationLink {

                                TrendingDetailView(
                                    object: LearningTopic(
                                        name: item.name,
                                        imageName: item.imageName,
                                        summary: item.summary,
                                        description: item.description,
                                        learners: nil,
                                        category: item.category
                                    )
                                )

                            } label: {

                                VStack(alignment: .leading, spacing: 12) {

                                    Image(item.imageName)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(height: 140)
                                        .frame(maxWidth: .infinity)
                                        .clipShape(
                                            RoundedRectangle(cornerRadius: 16)
                                        )

                                    Text(item.name)
                                        .font(.headline)

                                    Text(item.summary)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                        .lineLimit(2)

                                }
                                .padding()
                                .background(.ultraThinMaterial)
                                .clipShape(
                                    RoundedRectangle(cornerRadius: 18)
                                )

                            }
                            .buttonStyle(.plain)

                        }

                    }
                    .padding()

                }

            }

        }
        .navigationTitle(category.title)
        .navigationBarTitleDisplayMode(.inline)

    }

}

#Preview {

    NavigationStack {

        CategoryDetailView(
            category: CategoryData.categories.first!
        )

    }

}
