import SwiftUI

struct LibraryView: View {

    @StateObject private var history = HistoryService.shared
    @State private var searchText = ""
    @State private var expandedItem: UUID?

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

                    List {

                        ForEach(filteredHistory) { item in

                            LibraryRow(
                                item: item,
                                isExpanded: expandedItem == item.id,

                                onTap: {

                                    expandedItem = expandedItem == item.id ? nil : item.id

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
                            .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {

                                Button(role: .destructive) {

                                    history.delete(item)

                                } label: {

                                    Label("Delete", systemImage: "trash")

                                }

                            }

                        }

                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)

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
