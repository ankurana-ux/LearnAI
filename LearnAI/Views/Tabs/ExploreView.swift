import SwiftUI

struct ExploreView: View {
    
    @StateObject private var history = HistoryService.shared
    
    let categories = ExploreData.categories

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {

        NavigationStack {

            ScrollView {

                VStack(spacing: 32) {

                    ExploreHeaderView()

                    DailyMomentumCard()

                    CurrentObjectiveCard()

                    QuizCard()

                    DailyCuriositySection()

                    WorldLearningSection()

                    TrendingSection()

                    FunFactCard()

                    MysteryObjectCard()

                    BadgeProgressCard()

                    FactCard()

                    RareFindsCard()

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

                }
                .padding(.horizontal, 20)

                .padding(.vertical)

            }
            .navigationTitle("Explore")
        }
        
    }
}

#Preview {

    ExploreView()

}
