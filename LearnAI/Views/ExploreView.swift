import SwiftUI

struct ExploreView: View {

    @StateObject private var history = HistoryService.shared

    let categories = ExploreData.categories


    let columns = [

        GridItem(.flexible()),
        GridItem(.flexible())

    ]

    let trendingObjects = ExploreData.trendingObjects

    var body: some View {

        NavigationStack {

            ScrollView {

                VStack(spacing: 32) {

                    NavigationLink {

                        TrendingDetailView(
                            object: ExploreData.dailyObject
                        )

                    } label: {

                        DailyCuriosityCard(
                            object: ExploreData.dailyObject
                        )

                    }
                    .buttonStyle(.plain)
                    ExploreSection(
                        title: "Trending Today",
                        systemImage: "flame.fill"
                    ) {

                        ScrollView(.horizontal, showsIndicators: false) {

                            HStack(spacing: 16) {

                                ForEach(trendingObjects) { object in

                                    NavigationLink {

                                        TrendingDetailView(object: object)

                                    } label: {

                                        TrendingCard(object: object)

                                    }

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

                                CategoryCard(category: category)

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
                                        .clipShape(RoundedRectangle(cornerRadius: 18))

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
