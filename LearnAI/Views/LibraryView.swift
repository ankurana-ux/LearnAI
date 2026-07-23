import SwiftUI

struct LibraryView: View {

    @StateObject private var history = HistoryService.shared
    @State private var searchText = ""
    @State private var expandedItem: UUID?
    @State private var openSwipeID: UUID?

    private var filteredHistory: [ScanHistory] {

        if searchText.isEmpty {
            return history.history
        }

        return history.history.filter {
            $0.name.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {

        NavigationStack {

            Group {

                if filteredHistory.isEmpty {

                    ContentUnavailableView(
                        "No Scans Yet",
                        systemImage: "books.vertical",
                        description: Text("Start scanning objects to build your library.")
                    )

                } else {

                    ScrollView {

                        LazyVStack(spacing: 16) {

                            ForEach(filteredHistory) { item in

                                SwipeableRow(
                                    id: item.id,
                                    openSwipeID: $openSwipeID,
                                    isEnabled: expandedItem != item.id,

                                    trailing: {

                                        ZStack {

                                            Color.red

                                            Button {

                                                history.delete(item)

                                            } label: {

                                                Image(systemName: "trash.fill")
                                                    .font(.title2)
                                                    .foregroundStyle(.white)
                                                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                                            }
                                            .buttonStyle(.plain)

                                        }

                                    },

                                    content: {

                                        LibraryRow(
                                            item: item,
                                            isExpanded: expandedItem == item.id,

                                            onTap: {

                                                openSwipeID = nil

                                                withAnimation(.spring(
                                                    response: 0.35,
                                                    dampingFraction: 0.85
                                                )) {

                                                    expandedItem = expandedItem == item.id ? nil : item.id

                                                }

                                            },

                                            onFavorite: {

                                                history.toggleFavorite(for: item.id)

                                            },

                                            onLearnMore: {

                                                Task {

                                                    await history.loadAIInfo(for: item.id)

                                                }

                                            }
                                        )

                                    }
                                )
                                .padding(.horizontal)
                                .shadow(radius: 2)

                            }

                        }
                        .padding(.vertical)

                    }

                }

            }
            .navigationTitle("Library")
            .searchable(text: $searchText, prompt: "Search your scans")

        }

    }

}

#Preview {
    LibraryView()
}
