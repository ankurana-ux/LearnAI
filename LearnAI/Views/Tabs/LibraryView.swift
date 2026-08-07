import SwiftUI

struct LibraryView: View {

    @StateObject private var history = HistoryService.shared
    @State private var expandedItem: UUID?

    private var filteredHistory: [ScanHistory] {

        history.history

    }

    var body: some View {

        NavigationStack {

            ScrollView {

                VStack(spacing: AppTheme.Spacing.section) {

                    LibraryHeader()

                    RecommendedCollectionCard()

                    FunFactCard()

                    LearningCollectionsSection()

                    if filteredHistory.isEmpty {

                        ContentUnavailableView(
                            "No Discoveries Yet",
                            systemImage: "books.vertical",
                            description: Text("Start scanning objects to build your collection.")
                        )

                    } else {

                        RecentDiscoveriesSection()
                            .padding(.horizontal, 5)

                    }

                }
                .padding(.horizontal, 10)
                .padding(.top, 40)      // or 24, 32 depending on the look you want
                .padding(.bottom, 100)

            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(.hidden, for: .navigationBar)

        }

    }

}

#Preview {
    LibraryView()
}
