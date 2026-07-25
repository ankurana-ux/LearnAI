import SwiftUI

struct ExploreView: View {

    let categories = [

        ExploreCategory(title: "Animals", icon: "pawprint.fill", color: .orange),
        ExploreCategory(title: "Plants", icon: "leaf.fill", color: .green),
        ExploreCategory(title: "Technology", icon: "laptopcomputer", color: .blue),
        ExploreCategory(title: "Food", icon: "fork.knife", color: .red),
        ExploreCategory(title: "Vehicles", icon: "car.fill", color: .purple),
        ExploreCategory(title: "Space", icon: "sparkles", color: .indigo)

    ]

    let columns = [

        GridItem(.flexible()),
        GridItem(.flexible())

    ]

    var body: some View {

        NavigationStack {

            ScrollView {

                VStack(spacing: 32) {

                    ExploreSection(
                        title: "Trending Today",
                        systemImage: "flame.fill"
                    ) {

                        ScrollView(.horizontal, showsIndicators: false) {

                            HStack(spacing: 16) {

                                TrendingCard(
                                    title: "Panda",
                                    emoji: "🐼"
                                )

                                TrendingCard(
                                    title: "Saturn",
                                    emoji: "🪐"
                                )

                                TrendingCard(
                                    title: "Volcano",
                                    emoji: "🌋"
                                )

                                TrendingCard(
                                    title: "Octopus",
                                    emoji: "🐙"
                                )

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
