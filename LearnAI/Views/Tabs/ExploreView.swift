import SwiftUI

struct ExploreView: View {

    @StateObject private var history = HistoryService.shared

    let categories = ExploreData.categories

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    let trendingTopics = ExploreData.trendingTopics

    var body: some View {

        NavigationStack {

            ScrollView {

                VStack(spacing: 32) {

                    NavigationLink {

                        TrendingDetailView(
                            object: ExploreData.dailyTopic
                        )

                    } label: {

                        DailyCuriosityCard(
                            object: ExploreData.dailyTopic
                        )

                    }
                    .buttonStyle(.plain)

                    VStack(alignment: .leading, spacing: 16) {

                        Text("🌍 The World Is Learning")
                            .font(.title2)
                            .bold()
                            .padding(.horizontal)

                        ScrollView(.horizontal, showsIndicators: false) {

                            HStack(spacing: 16) {

                                ForEach(WorldLearningData.objects) { object in

                                    NavigationLink {

                                        TrendingDetailView(
                                            object: object
                                        )

                                    } label: {

                                        WorldLearningCard(object: object)
                                            .frame(width: 320)

                                    }
                                    .buttonStyle(.plain)

                                }

                            }
                            .padding(.horizontal)

                        }

                    }

                    ExploreSection(
                        title: "Trending Today",
                        systemImage: "flame.fill"
                    ) {

                        ScrollView(.horizontal, showsIndicators: false) {

                            HStack(spacing: 16) {

                                ForEach(trendingTopics) { topic in

                                    NavigationLink {

                                        TrendingDetailView(object: topic)

                                    } label: {

                                        TrendingCard(object: topic)

                                    }
                                    .buttonStyle(.plain)

                                }

                            }
                            .padding(.horizontal)

                        }

                    }

                    ExploreSection(
                        title: "Categories",
                        systemImage: "square.grid.2x2.fill"
                    ) {

                        LazyVGrid(
                            columns: columns,
                            spacing: 18
                        ) {

                            ForEach(categories) { category in

                                NavigationLink {

                                    CategoryDetailView(category: category)

                                } label: {

                                    CategoryCard(category: category)

                                }
                                .buttonStyle(.plain)

                            }

                        }
                        .padding(.horizontal)

                    }

                    ExploreSection(
                        title: "Continue Learning",
                        systemImage: "book.fill"
                    ) {

                        if history.history.isEmpty {

                            ContentUnavailableView(
                                "Nothing Yet",
                                systemImage: "book.closed",
                                description: Text("Scan objects to build your learning library.")
                            )
                            .padding(.horizontal)

                        } else {

                            VStack(spacing: 16) {

                                ForEach(history.history.prefix(5)) { item in

                                    NavigationLink {

                                        Text(item.name)
                                            .navigationTitle(item.name)

                                    } label: {

                                        HStack {

                                            Image(systemName: "book.fill")
                                                .font(.title2)
                                                .foregroundStyle(.blue)

                                            VStack(alignment: .leading) {

                                                Text(item.name)
                                                    .font(.headline)

                                                Text(item.date.formatted(date: .abbreviated, time: .omitted))
                                                    .font(.caption)
                                                    .foregroundStyle(.secondary)

                                            }

                                            Spacer()

                                            Image(systemName: "chevron.right")
                                                .foregroundStyle(.secondary)

                                        }
                                        .padding()
                                        .background(.ultraThinMaterial)
                                        .clipShape(
                                            RoundedRectangle(cornerRadius: 18)
                                        )

                                    }

                                }

                            }
                            .padding(.horizontal)

                        }

                    }

                }
                .padding(.vertical)

            }
            .navigationTitle("Explore")

        }

    }

}

#Preview {
    ExploreView()
}
