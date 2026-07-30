import SwiftUI

struct ExploreView: View {
    
    @State private var dailyCuriosity: LearningTopic?
    @State private var isLoadingCuriosity = false
    @StateObject private var history = HistoryService.shared
    @State private var worldLearningTopics: [LearningTopic] = []
    @State private var isLoadingWorldLearning = false
    @State private var trendingTopics: [LearningTopic] = []
    @State private var isLoadingTrending = false

    let categories = ExploreData.categories

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]


    private func loadWorldLearning() {

        Task {

            isLoadingWorldLearning = true

            do {

                let topics = try await WorldLearningService.shared.fetchTopics()

                await MainActor.run {

                    worldLearningTopics = topics
                    isLoadingWorldLearning = false

                }

            } catch {

                print("World Learning failed:", error)

                await MainActor.run {

                    isLoadingWorldLearning = false

                }

            }

        }

    }
    
    private func loadTrending() {

        Task {

            isLoadingTrending = true

            do {

                let topics = try await TrendingService.shared.fetchTrending()

                await MainActor.run {

                    trendingTopics = topics
                    isLoadingTrending = false

                }

            } catch {

                print("❌ Trending failed:", error.localizedDescription)

                await MainActor.run {

                    isLoadingTrending = false

                }

            }

        }

    }

    private func loadDailyCuriosity() {

        if DailyCuriosityCache.shared.isToday(),
           let cached = DailyCuriosityCache.shared.load() {

            dailyCuriosity = cached
            return
        }


        Task {

            isLoadingCuriosity = true

            do {

                let result = try await ExploreAIService.shared.generateDailyCuriosity(
                    history: HistoryService.shared.history
                )


                DailyCuriosityCache.shared.save(result)
                DailyCuriosityCache.shared.saveDate()


                await MainActor.run {

                    dailyCuriosity = result
                    isLoadingCuriosity = false

                }


            } catch {

                print(
                    "❌ Daily Curiosity failed:",
                    error.localizedDescription
                )


                await MainActor.run {

                    isLoadingCuriosity = false

                }

            }

        }

    }


    var body: some View {

        NavigationStack {

            ScrollView {

                VStack(spacing: 32) {


                    if let curiosity = dailyCuriosity {

                        NavigationLink {

                            TrendingDetailView(
                                object: curiosity
                            )

                        } label: {

                            DailyCuriosityCard(
                                object: curiosity
                            )

                        }
                        .buttonStyle(.plain)

                    } else {

                        ProgressView("Creating today's curiosity...")
                            .padding()

                    }


                    VStack(alignment: .leading, spacing: 16) {

                        Text("🌍 The World Is Learning")
                            .font(.title2)
                            .bold()
                            .padding(.horizontal)

                        ScrollView(.horizontal, showsIndicators: false) {

                            HStack(spacing: 16) {

                                if isLoadingWorldLearning {

                                    ProgressView("Discovering what the world is learning...")

                                } else {

                                    ForEach(worldLearningTopics) { object in

                                        NavigationLink {

                                            TrendingDetailView(
                                                object: object
                                            )

                                        } label: {

                                            WorldLearningCard(object: object)
                                                .frame(width: 320)

                                        }

                                    }

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

                }
                .padding(.vertical)

            }
            .navigationTitle("Explore")
            .onAppear {

                if dailyCuriosity == nil {

                    loadDailyCuriosity()

                }
                if worldLearningTopics.isEmpty {

                    loadWorldLearning()

                }
                if trendingTopics.isEmpty {

                    loadTrending()

                }

            }

        }

    }
    

}


#Preview {

    ExploreView()

}
