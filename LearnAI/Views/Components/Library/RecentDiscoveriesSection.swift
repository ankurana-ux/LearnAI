import SwiftUI

struct RecentDiscoveriesSection: View {

    @ObservedObject private var history = HistoryService.shared
    @State private var expandedItem: UUID?

    var body: some View {

        VStack(alignment: .leading, spacing: 20) {

            HStack {

                AppSectionHeader(
                    title: "Recent Discoveries",
                    icon: "clock.fill",
                    color: .blue
                )

                Spacer()

                Button("View All") {

                }
                .font(.subheadline.weight(.semibold))

            }

            ForEach(history.history.prefix(3)) { item in

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

            }

        }

    }

}

#Preview {

    RecentDiscoveriesSection()

}
