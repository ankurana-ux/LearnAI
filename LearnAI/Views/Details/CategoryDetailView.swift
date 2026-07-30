import SwiftUI

struct CategoryDetailView: View {
    
    let category: ExploreCategory
    
    @State private var items: [LearningTopic] = []
    @State private var isLoading = false

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    private func loadCategoryItems() {

        Task {

            isLoading = true

            do {

                let result = try await CategoryService.shared.fetchCategoryItems(
                    category: category.title
                )

                await MainActor.run {

                    items = result
                    isLoading = false

                }

            } catch {

                print(
                    "❌ Category loading failed:",
                    error.localizedDescription
                )

                await MainActor.run {

                    isLoading = false

                }

            }

        }

    }

    var body: some View {

        Group {

            if isLoading {

                ProgressView("Discovering \(category.title)...")

            } else if items.isEmpty {

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
                                    object: item
                                )

                            } label: {

                                VStack(alignment: .leading, spacing: 12) {

                                    CategoryTopicImage(topic: item)
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
        .onAppear {

            if items.isEmpty {

                loadCategoryItems()

            }

        }

    }
    
}


#Preview {

    NavigationStack {

        CategoryDetailView(
            category: CategoryData.categories.first!
        )

    }

}
